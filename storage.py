# -*- coding: utf-8 -*-
"""session 数据存储层 —— 同一套接口，三种后端。

云平台的免费实例文件系统是临时的，重启 / 休眠唤醒后 session 全丢。
把数据放到外部对象存储就能跨重启存活：

  1. s3       Cloudflare R2 / AWS S3 / 任何 S3 兼容存储（推荐：无休眠、10GB 免费）
  2. supabase Supabase Storage（免费 1GB，但项目 7 天无活动会被暂停）
  3. local    本地文件系统（默认；云平台上重启即丢）

用法：
    from storage import build_store
    STORE = build_store(session_dir)
    STORE.write_text("local_data.json", "...")
    raw = STORE.read_text("local_data.json")

所有后端共用一层进程内缓存：命中缓存不发网络请求，写入时先更新缓存再同步远端。
远端写失败只记日志、不抛异常 —— 一次网络抖动不该把登录流程整个打断。

环境变量
--------
S3_BUCKET / S3_ENDPOINT / S3_ACCESS_KEY / S3_SECRET_KEY / S3_REGION(默认 auto)
SUPABASE_URL / SUPABASE_SERVICE_KEY / SUPABASE_BUCKET(默认 chsi)
都不配置时自动用 local。
"""
import os
import time
import threading
import urllib.parse

try:
    import requests
except Exception:  # pragma: no cover - requests 是项目硬依赖，这里只做兜底
    requests = None


def _log(msg):
    print("[storage] %s" % msg, flush=True)


# ---------------------------------------------------------------- 后端实现

class LocalStore(object):
    """本地文件系统。key 用 / 分隔，会自动映射成子目录。"""

    name = "local"

    def __init__(self, root):
        self.root = root
        try:
            os.makedirs(root, exist_ok=True)
        except OSError as e:
            _log("无法创建目录 %s: %s" % (root, e))

    def _path(self, key):
        return os.path.join(self.root, *key.split("/"))

    def _ensure_parent(self, key):
        parent = os.path.dirname(self._path(key))
        if parent:
            os.makedirs(parent, exist_ok=True)

    def read_bytes(self, key):
        try:
            with open(self._path(key), "rb") as f:
                return f.read()
        except (IOError, OSError):
            return None

    def write_bytes(self, key, data):
        self._ensure_parent(key)
        tmp = self._path(key) + ".tmp"
        with open(tmp, "wb") as f:
            f.write(data)
        os.replace(tmp, self._path(key))  # 原子替换，避免读到半截文件

    def exists(self, key):
        return os.path.exists(self._path(key))

    def delete(self, key):
        try:
            os.remove(self._path(key))
        except (IOError, OSError):
            pass

    def mtime(self, key):
        try:
            return str(int(os.path.getmtime(self._path(key))))
        except (IOError, OSError):
            return ""


class S3Store(object):
    """S3 兼容对象存储。Cloudflare R2 只需要 endpoint 换成 <account>.r2.cloudflarestorage.com。"""

    name = "s3"

    def __init__(self, bucket, endpoint, access_key, secret_key, region="auto"):
        import boto3
        from botocore.config import Config

        self.bucket = bucket
        self.client = boto3.client(
            "s3",
            endpoint_url=endpoint,
            aws_access_key_id=access_key,
            aws_secret_access_key=secret_key,
            region_name=region,
            config=Config(signature_version="s3v4",
                          retries={"max_attempts": 2, "mode": "standard"},
                          connect_timeout=5, read_timeout=15),
        )

    def read_bytes(self, key):
        try:
            obj = self.client.get_object(Bucket=self.bucket, Key=key)
            return obj["Body"].read()
        except Exception as e:
            if "NoSuchKey" not in str(e) and "404" not in str(e):
                _log("读取 %s 失败: %s" % (key, e))
            return None

    def write_bytes(self, key, data):
        self.client.put_object(Bucket=self.bucket, Key=key, Body=data,
                               ContentType="application/octet-stream")

    def exists(self, key):
        try:
            self.client.head_object(Bucket=self.bucket, Key=key)
            return True
        except Exception:
            return False

    def delete(self, key):
        try:
            self.client.delete_object(Bucket=self.bucket, Key=key)
        except Exception as e:
            _log("删除 %s 失败: %s" % (key, e))

    def mtime(self, key):
        try:
            head = self.client.head_object(Bucket=self.bucket, Key=key)
            return str(int(head["LastModified"].timestamp()))
        except Exception:
            return ""


class SupabaseStore(object):
    """Supabase Storage。bucket 需要先建好，权限设为 private，用 service_role key 访问。"""

    name = "supabase"

    def __init__(self, base_url, service_key, bucket="chsi"):
        self.base = base_url.rstrip("/")
        self.key = service_key
        self.bucket = bucket

    def _url(self, key):
        return "%s/storage/v1/object/%s/%s" % (
            self.base, self.bucket, urllib.parse.quote(key))

    def _headers(self, extra=None):
        h = {
            "apikey": self.key,
            "Authorization": "Bearer %s" % self.key,
        }
        if extra:
            h.update(extra)
        return h

    def read_bytes(self, key):
        if requests is None:
            return None
        try:
            r = requests.get(self._url(key), headers=self._headers(), timeout=15)
            if r.status_code == 200:
                return r.content
            if r.status_code not in (400, 404):
                _log("读取 %s 失败: HTTP %s" % (key, r.status_code))
        except Exception as e:
            _log("读取 %s 异常: %s" % (key, e))
        return None

    def write_bytes(self, key, data):
        if requests is None:
            return
        r = requests.post(
            self._url(key),
            headers=self._headers({
                "Content-Type": "application/octet-stream",
                "x-upsert": "true",          # 已存在则覆盖
                "cache-control": "no-cache",
            }),
            data=data,
            timeout=30,
        )
        if r.status_code not in (200, 201):
            raise IOError("HTTP %s %s" % (r.status_code, r.text[:200]))

    def exists(self, key):
        if requests is None:
            return False
        try:
            r = requests.head(self._url(key), headers=self._headers(), timeout=10)
            if r.status_code == 200:
                return True
            if r.status_code == 405:          # 有些版本不支持 HEAD，退回 GET
                return self.read_bytes(key) is not None
        except Exception:
            pass
        return False

    def delete(self, key):
        if requests is None:
            return
        try:
            requests.delete(self._url(key), headers=self._headers(), timeout=10)
        except Exception as e:
            _log("删除 %s 失败: %s" % (key, e))

    def mtime(self, key):
        return ""  # 由缓存层用内容哈希兜底


# ---------------------------------------------------------------- 缓存包装

class CachedStore(object):
    """给任意后端套一层进程内缓存。

    - 读：先查缓存，未命中才打远端，命中后缓存（None 不缓存，避免“先读后写”被锁死）
    - 写：先落缓存再同步远端；远端失败只记日志，业务继续跑
    - mtime：写入时记时间戳，供照片 URL 做 cache-busting
    """

    def __init__(self, backend):
        self.backend = backend
        self.name = backend.name
        self._lock = threading.RLock()
        self._cache = {}
        self._mtimes = {}

    # -- 原始字节
    def read_bytes(self, key):
        with self._lock:
            if key in self._cache:
                return self._cache[key]
        data = self.backend.read_bytes(key)
        if data is not None:
            with self._lock:
                self._cache[key] = data
        return data

    def write_bytes(self, key, data):
        if data is None:
            return
        with self._lock:
            self._cache[key] = data
            self._mtimes[key] = str(int(time.time()))
        try:
            self.backend.write_bytes(key, data)
        except Exception as e:
            _log("同步 %s 到远端失败（数据仅存于内存）: %s" % (key, e))

    def exists(self, key):
        with self._lock:
            if key in self._cache:
                return True
        return self.backend.exists(key)

    def delete(self, key):
        with self._lock:
            self._cache.pop(key, None)
            self._mtimes.pop(key, None)
        try:
            self.backend.delete(key)
        except Exception as e:
            _log("删除 %s 失败: %s" % (key, e))

    def mtime(self, key):
        with self._lock:
            if key in self._mtimes:
                return self._mtimes[key]
        return self.backend.mtime(key)

    # -- 文本便捷方法
    def read_text(self, key):
        data = self.read_bytes(key)
        if data is None:
            return None
        try:
            return data.decode("utf-8")
        except UnicodeDecodeError:
            return data.decode("utf-8", "replace")

    def write_text(self, key, text):
        self.write_bytes(key, text.encode("utf-8"))


# ---------------------------------------------------------------- 工厂

def build_store(session_dir):
    """按环境变量选后端，返回带缓存的存储对象。"""
    bucket = os.environ.get("S3_BUCKET")
    endpoint = os.environ.get("S3_ENDPOINT")
    access = os.environ.get("S3_ACCESS_KEY")
    secret = os.environ.get("S3_SECRET_KEY")

    if bucket and endpoint and access and secret:
        try:
            store = CachedStore(S3Store(
                bucket=bucket,
                endpoint=endpoint,
                access_key=access,
                secret_key=secret,
                region=os.environ.get("S3_REGION", "auto"),
            ))
            _log("后端 = S3/R2 (bucket=%s)" % bucket)
            return store
        except Exception as e:
            _log("S3 初始化失败，回退本地存储: %s" % e)

    sb_url = os.environ.get("SUPABASE_URL")
    sb_key = os.environ.get("SUPABASE_SERVICE_KEY")
    if sb_url and sb_key:
        store = CachedStore(SupabaseStore(
            base_url=sb_url,
            service_key=sb_key,
            bucket=os.environ.get("SUPABASE_BUCKET", "chsi"),
        ))
        _log("后端 = Supabase Storage (bucket=%s)" % os.environ.get("SUPABASE_BUCKET", "chsi"))
        return store

    _log("后端 = local (%s)" % session_dir)
    return CachedStore(LocalStore(session_dir))
