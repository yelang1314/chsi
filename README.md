---
title: 学历档案演示站
emoji: 🎓
colorFrom: blue
colorTo: indigo
sdk: docker
app_port: 7860
pinned: false
---

# 学历档案演示站

Python 单端口 HTTP 服务，自带 Docker 镜像，可直接部署到任何支持 Docker 的云平台。

## 一键部署

| 平台 | 操作 | 免费域名 |
| --- | --- | --- |
| Render | New → **Web Service** → 选仓库（自动识别 Dockerfile） | `xxx.onrender.com` |
| Koyeb | Create Service → **Dockerfile** | `xxx.koyeb.app` |
| Hugging Face Spaces | 需付费档（2026-10 起 Docker SDK 不再免费） | `用户名-空间名.hf.space` |
| 本机 / 自建服务器 | `docker build -t chsi . && docker run -p 7860:7860 chsi` | 自己的域名 |

## 环境变量

| 变量 | 默认值 | 说明 |
| --- | --- | --- |
| `PORT` | `7860`（镜像内） | 监听端口，平台注入时以其为准 |
| `HOST` | `0.0.0.0` | 监听地址 |
| `SESSION_DIR` | 自动探测 | 本地后端的 session 目录，优先级最高 |
| `DATA_DIR` | `/data` | 持久盘根目录，session 会写到 `$DATA_DIR/session` |
| `COMPRESS_PHOTOS` | `1` | 上传照片是否压缩，设 `0` 关闭 |
| `S3_BUCKET` / `S3_ENDPOINT` / `S3_ACCESS_KEY` / `S3_SECRET_KEY` / `S3_REGION` | 空 | 配齐即启用 R2 / S3 后端 |
| `SUPABASE_URL` / `SUPABASE_SERVICE_KEY` / `SUPABASE_BUCKET` | 空 | 配齐即启用 Supabase 后端 |

## 数据持久化（重点）

云平台免费实例的文件系统是**临时**的：休眠唤醒、重新部署都会重置，`session/` 里的
登录 cookie、照片、`local_data.json`（姓名/学校/专业）、归档 HTML 会全部清空。

解决办法是把数据放到外部对象存储。`storage.py` 提供了统一接口，三种后端按环境变量自动选择：

| 后端 | 触发条件 | 免费额度 | 备注 |
| --- | --- | --- | --- |
| **R2 / S3**（推荐） | 配齐 4 个 `S3_*` | R2 10GB 存储 + 无出网费 | 不会休眠，最稳 |
| Supabase Storage | 配齐 `SUPABASE_URL` + `SUPABASE_SERVICE_KEY` | 1GB | 免费项目 7 天无活动会被暂停 |
| 本地文件 | 都不配（默认） | — | 重启即丢，适合本地开发 |

### 用 Cloudflare R2

1. Cloudflare 控制台 → **R2** → **Create bucket**，名字填 `chsi`
2. 右侧栏记下 **Account ID**
3. R2 → **Manage API Tokens** → Create API token → 权限选 **Object Read & Write**，
   记下 **Access Key ID** 和 **Secret Access Key**（只显示一次）
4. 在 Render 的 Environment 里加：

```
S3_BUCKET=chsi
S3_ENDPOINT=https://<Account ID>.r2.cloudflarestorage.com
S3_ACCESS_KEY=<Access Key ID>
S3_SECRET_KEY=<Secret Access Key>
S3_REGION=auto
```

### 用 Supabase

1. 新建项目 → **Storage** → New bucket，名字 `chsi`，**不要**勾 Public
2. **Settings → API** → 复制 Project URL 和 `service_role` key
3. 环境变量：

```
SUPABASE_URL=https://xxxx.supabase.co
SUPABASE_SERVICE_KEY=<service_role key>
SUPABASE_BUCKET=chsi
```

> 切换后端后第一次启动是空数据 —— 旧数据还躺在本地 `session/` 目录里，不会自动上传，
> 需要重新登录、重新录入。

## 本地运行

```bash
pip install -r requirements.txt
python server.py            # 默认 80 端口，需管理员权限
PORT=8080 python server.py  # 换个端口免提权
```

打开 <http://127.0.0.1/wap/index.jsp>。不配任何存储变量时数据写本地 `./session/`，行为和以前一致。
