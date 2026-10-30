# -*- coding: utf-8 -*-
"""
学信网本地站点服务器（含真实登录代理 API）
用法: 运行后访问 http://127.0.0.1/wap/index.jsp

API 接口:
  POST /api/login       真实登录学信网，保存 cookie 与登录后数据
  GET  /api/archive     用已保存 cookie 真实请求官方档案页
  GET  /api/proxy?url=  用已保存 cookie 代理请求官方任意接口
  GET  /api/cookies     查看已保存 cookie（调试）
"""
import http.server
import socketserver
import os
import json
import re
import base64
import urllib.parse
import requests
import datetime
import hashlib
import tempfile

import storage

PORT = int(os.environ.get("PORT", "80"))
DIR = os.path.dirname(os.path.abspath(__file__))


def _resolve_session_dir():
    """解析 session 目录，取第一个可写的位置，按优先级：

    1. 环境变量 SESSION_DIR —— 显式指定，最高优先级
    2. $DATA_DIR/session（默认 /data/session）—— 云平台持久盘挂载点，
       Hugging Face Spaces / Render / Koyeb 开持久存储后都挂在这里
    3. 项目目录下的 ./session —— 本地运行
    4. 系统临时目录 —— 容器内项目目录只读时的兜底

    持久盘没挂载或不可写时自动降级，不会因为写不进去导致启动失败。
    """
    candidates = []
    if os.environ.get("SESSION_DIR"):
        candidates.append(os.environ["SESSION_DIR"])
    # 只在持久盘真实存在时才纳入候选：避免在 Windows 本地误建 C:\data\session
    data_root = os.environ.get("DATA_DIR") or ("/data" if os.name != "nt" else "")
    if data_root and os.path.isdir(data_root):
        candidates.append(os.path.join(data_root, "session"))
    candidates.append(os.path.join(DIR, "session"))
    candidates.append(os.path.join(tempfile.gettempdir(), "chsi-session"))

    for path in candidates:
        try:
            os.makedirs(path, exist_ok=True)
            probe = os.path.join(path, ".write_probe")
            with open(probe, "w", encoding="utf-8") as fp:
                fp.write("ok")
            os.remove(probe)
            return path
        except OSError:
            continue
    return os.path.join(DIR, "session")


SESSION_DIR = _resolve_session_dir()
COOKIE_FILE = os.path.join(SESSION_DIR, "session_cookies.json")
ARCHIVE_FILE = os.path.join(SESSION_DIR, "archive_after_login.html")
LOCAL_DATA_FILE = os.path.join(SESSION_DIR, "local_data.json")
CURRENT_USER_FILE = os.path.join(SESSION_DIR, "current_user.json")
PHOTO_DIR = os.path.join(SESSION_DIR, "photos")

# ---- 存储后端 ----
# 默认写本地文件；配了 S3/R2 或 Supabase 环境变量就自动切到对象存储，
# 这样云平台重启 / 休眠唤醒后 cookie、照片、档案都还在。
# 详见 storage.py 顶部说明。
STORE = storage.build_store(SESSION_DIR)

# 对象存储里的 key（本地后端会映射成 SESSION_DIR 下的同名文件）
KEY_COOKIES = "session_cookies.json"
KEY_ARCHIVE = "archive_after_login.html"
KEY_LOCAL_DATA = "local_data.json"
KEY_CURRENT_USER = "current_user.json"
PHOTO_EXT = ".jpg"
# 新上传照片是否压缩（缩放到最长边<=1200、JPEG 质量85）；环境变量设为 0 可关闭
COMPRESS_PHOTOS = os.environ.get("COMPRESS_PHOTOS", "1") != "0"

# ---- 在线验证报告 PDF 生成资源（样式与官方备案表一致） ----
_PDF_ASSETS_DIR = os.path.join(DIR, "archive", "assets", "pdf")
_PDF_BG_PATH = os.path.join(_PDF_ASSETS_DIR, "bg.png")
_PDF_LOGO_PATH = os.path.join(_PDF_ASSETS_DIR, "logo.png")
_WINDIR = os.environ.get("WINDIR", r"C:\WINDOWS")
# 中文字体查找顺序：优先思源黑体（与官方 PDF 同源），回退 Windows 自带黑体
_PDF_FONT_CANDIDATES = [
    os.path.join(_WINDIR, "Fonts", "SourceHanSansCN-Normal.ttf"),
    os.path.join(_WINDIR, "Fonts", "Noto Sans SC (TrueType).otf"),
    os.path.join(_WINDIR, "Fonts", "msyh.ttc"),
    os.path.join(_WINDIR, "Fonts", "simhei.ttf"),
]

SERVICE = "https://my.chsi.com.cn/archive/j_spring_cas_security_check"
LOGIN_URL = "https://account.chsi.com.cn/passport/login"
ARCHIVE_URL = "https://my.chsi.com.cn/archive/wap/index.action"

# 移动端 UA：官方 WAP 页面按 UA 返回手机版
UA = ("Mozilla/5.0 (Linux; Android 13; vivo V2148A) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36")


def _ensure_session_dir():
    os.makedirs(SESSION_DIR, exist_ok=True)


def load_cookies():
    """加载已保存的 cookie 字典，无则返回 {}"""
    raw = STORE.read_text(KEY_COOKIES)
    if not raw:
        return {}
    try:
        return json.loads(raw)
    except Exception:
        return {}


def save_cookies(cookies):
    STORE.write_text(KEY_COOKIES,
                     json.dumps(cookies, ensure_ascii=False, indent=2))


# ---- 本地维护数据（admin 管理页写入） ----
XJ_FIELDS = ["id", "xm", "xb", "csrq", "mz", "sfzh", "yxmc", "xsh", "fy", "zymc",
             "cc", "xxxs", "xllb", "xh", "bh", "rxrq", "byrq", "xjzt", "xz",
             "reportNo", "verifyCode", "validFrom", "validTo", "reportStatus"]
XL_FIELDS = ["id", "xm", "xb", "csrq", "yxmc", "zymc", "cc", "xxxs", "xllb",
             "zsbh", "bjyjl", "rxrq", "byrq", "xz", "fzrq", "xzm",
             "reportNo", "verifyCode", "validFrom", "validTo", "reportStatus"]


def load_local_data():
    raw = STORE.read_text(KEY_LOCAL_DATA)
    if not raw:
        return {"accounts": {}}
    try:
        return json.loads(raw)
    except Exception:
        return {"accounts": {}}


def save_local_data(data):
    STORE.write_text(KEY_LOCAL_DATA,
                     json.dumps(data, ensure_ascii=False, indent=2))


def get_current_user():
    raw = STORE.read_text(KEY_CURRENT_USER)
    if not raw:
        return ""
    try:
        return (json.loads(raw).get("username") or "").strip()
    except Exception:
        return ""


def set_current_user(username):
    STORE.write_text(KEY_CURRENT_USER,
                     json.dumps({"username": username}, ensure_ascii=False))


def extract_json_raw(text, marker):
    """从 marker 后第一个 { 开始括号配平，返回原始 JSON 文本（保留 \\uXXXX 转义）"""
    idx = text.find(marker)
    if idx == -1:
        return None
    bidx = text.find("{", idx)
    if bidx == -1:
        return None
    depth = 0
    in_str = False
    esc = False
    for i in range(bidx, len(text)):
        c = text[i]
        if in_str:
            if esc:
                esc = False
            elif c == "\\":
                esc = True
            elif c == '"':
                in_str = False
            continue
        if c == '"':
            in_str = True
        elif c == "{":
            depth += 1
        elif c == "}":
            depth -= 1
            if depth == 0:
                return text[bidx:i + 1]
    return None


# ---- 照片文件存储（图片与 local_data.json 分离，避免 JSON 巨大导致读写缓慢） ----

def _ensure_photo_dir():
    os.makedirs(PHOTO_DIR, exist_ok=True)


def _photo_key_from_path(path):
    """根据照片接口路径返回字段名：lqpic.do -> lqPic，其余(xjpic/xlpic.do) -> xlPic"""
    return "lqPic" if path.endswith("lqpic.do") else "xlPic"


def _photo_key(item_id, key):
    """照片在存储里的 key（本地后端映射成 SESSION_DIR/photos/xxx.jpg）"""
    suffix = "lq" if key == "lqPic" else "xl"
    return "photos/%s_%s%s" % (item_id, suffix, PHOTO_EXT)


def _photo_url(item_id, key):
    """照片访问 URL（admin 页直接用作 <img src>）"""
    do = "lqpic.do" if key == "lqPic" else "xlpic.do"
    return "/archive/photo/%s?pid=%s" % (do, item_id)


def _photo_ver(item_id, key):
    """返回照片的版本标识，作为 URL 参数；无照片返回空字符串。

    照片更新后版本变化 -> URL 变化 -> 浏览器强制重新请求，绕过残留缓存。
    本地后端用文件 mtime，对象存储用写入时间戳。
    """
    return STORE.mtime(_photo_key(item_id, key))


def _pid_from_photo_url(url):
    """从照片 URL 提取 pid，如 /archive/photo/lqpic.do?pid=xj_xxx -> xj_xxx"""
    if not isinstance(url, str):
        return ""
    m = re.search(r"[?&]pid=([^&]+)", url)
    return m.group(1) if m else ""


def _keep_photo(item, pf, src_pid):
    """沿用旧照片：若源 pid 与当前 id 不一致且源文件存在，迁移到当前 id；最终 URL 以实际文件为准。"""
    if src_pid and src_pid != item["id"] and _photo_exists(src_pid, pf):
        _write_photo(item["id"], pf, _read_photo(src_pid, pf))
        _delete_photo(src_pid, pf)
    if _photo_exists(item["id"], pf):
        item[pf] = _photo_url(item["id"], pf)
    elif src_pid:
        item[pf] = _photo_url(src_pid, pf)


def _photo_exists(item_id, key):
    return bool(item_id) and STORE.exists(_photo_key(item_id, key))


def _write_photo(item_id, key, data):
    if not data:
        return
    STORE.write_bytes(_photo_key(item_id, key), data)


def _read_photo(item_id, key):
    return STORE.read_bytes(_photo_key(item_id, key))


def _delete_photo(item_id, key):
    STORE.delete(_photo_key(item_id, key))


def _decode_dataurl(dataurl):
    """解析 dataURL，返回 (mime, bytes)；失败返回 (None, None)"""
    if not isinstance(dataurl, str) or not dataurl.startswith("data:"):
        return None, None
    header, _, b64 = dataurl.partition(",")
    mime = "image/jpeg"
    m = re.search(r"data:([^;]+);base64", header)
    if m:
        mime = m.group(1).split(";")[0]
    try:
        data = base64.b64decode(b64)
    except Exception:
        return mime, None
    return mime, data


def _maybe_compress(data):
    """安装了 Pillow 时压缩照片（最长边<=1200、JPEG 质量85），否则原样返回"""
    if not COMPRESS_PHOTOS or not data:
        return data
    try:
        from PIL import Image
        import io
        im = Image.open(io.BytesIO(data))
        im = im.convert("RGB")
        w, h = im.size
        maxside = 1200
        if max(w, h) > maxside:
            scale = maxside / float(max(w, h))
            im = im.resize((max(1, int(w * scale)), max(1, int(h * scale))),
                           Image.LANCZOS)
        buf = io.BytesIO()
        im.save(buf, format="JPEG", quality=85, optimize=True)
        out = buf.getvalue()
        return out if len(out) < len(data) else data
    except Exception:
        return data


def build_xj_result(item):
    d = {
        "csrq": "", "hasXlPic": False, "xz": "", "xxxs": "", "bh": "",
        "zpCollateVo": None, "xsh": "", "yxmc": "", "showZpCollated": False,
        "showTxcjm": False, "xllb": "", "fy": "", "xjzt": "", "id": "",
        "hasLqPic": False, "showZppj": False, "cc": "", "xlzms": False,
        "mzItemName": "民族", "xb": "", "zymc": "", "mz": "", "rxrq": "",
        "xh": "", "sfzh": "", "xm": "", "byrq": "", "byrqItemName": "离校日期",
    }
    d.update({k: v for k, v in item.items() if v is not None})
    # 本地维护照片：文件存在则标记显示（详情页据此渲染图片）
    d["hasLqPic"] = _photo_exists(item.get("id"), "lqPic")
    d["hasXlPic"] = _photo_exists(item.get("id"), "xlPic")
    # 照片版本号：用于照片 URL 加 &v= 参数，绕过浏览器残留缓存
    d["lqPicVer"] = _photo_ver(item.get("id"), "lqPic")
    d["xlPicVer"] = _photo_ver(item.get("id"), "xlPic")
    return d


def build_xl_result(item):
    d = {
        "cc": "", "csrq": "", "xlzms": False, "hasXlPic": False, "xz": "",
        "fzrq": "", "xxxs": "", "bjyjl": "", "zsbh": "", "xb": "", "xzm": "",
        "zymc": "", "fzzsbh": "", "yxmc": "", "rxrq": "", "xllb": "", "xm": "",
        "fzyxmc": "", "byrq": "", "id": "",
    }
    d.update({k: v for k, v in item.items() if v is not None})
    # 本地维护学历照片：文件存在则标记显示
    d["hasXlPic"] = _photo_exists(item.get("id"), "xlPic")
    # 照片版本号：用于照片 URL 加 &v= 参数，绕过浏览器残留缓存
    d["xlPicVer"] = _photo_ver(item.get("id"), "xlPic")
    return d


def _report_defaults(item_id, typ):
    """基于 id 稳定生成报告默认值（报告编号/在线验证码/有效期），后台可覆盖"""
    h = hashlib.sha1((item_id or "").encode("utf-8")).hexdigest()
    today = datetime.date.today()
    valid_from = today.strftime("%Y年%m月%d日")
    valid_to = (today + datetime.timedelta(days=183)).strftime("%Y年%m月%d日")
    if typ == "xj":
        # 学籍在线验证报告编号：MOE + 年月日 + 8位码
        report_no = "MOE" + today.strftime("%Y%m%d") + h[:8].upper()
    else:
        # 学历证书电子注册备案表编号：18位数字
        report_no = "12026" + str(int(h[:13], 16)).zfill(13)
    # 官方在线验证码为 16 位：大写字母 A 开头 + 15 位大写字母/数字（A-Z0-9）
    charset = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    seed = int(h, 16)
    code = []
    for _ in range(15):
        seed = (seed * 1103515245 + 12345) & 0x7FFFFFFF
        code.append(charset[seed % 36])
    verify_code = "A" + "".join(code)
    return {
        "reportNo": report_no,
        "verifyCode": verify_code,
        "validFrom": valid_from,
        "validTo": valid_to,
    }


def _ensure_report_fields(item, typ):
    """确保记录含有报告字段，缺失时用默认值回填；返回报告字段字典"""
    defaults = _report_defaults(item.get("id"), typ)
    report = {}
    for k in ("reportNo", "verifyCode", "validFrom", "validTo"):
        v = item.get(k)
        if not v:
            v = defaults.get(k, "")
            item[k] = v
        report[k] = v
    return report


def _report_state(item, report):
    """返回报告状态: valid / closed / expired"""
    explicit = (item.get("reportStatus") or "").strip()
    if explicit in ("已关闭", "关闭", "closed"):
        return "closed"
    if explicit in ("已过期", "过期", "expired"):
        return "expired"
    valid_to = report.get("validTo", "")
    if valid_to:
        try:
            dt = datetime.datetime.strptime(valid_to, "%Y年%m月%d日").date()
            if dt < datetime.date.today():
                return "expired"
        except Exception:
            pass
    return "valid"


# ---- 在线验证报告 PDF 生成 ----

def _pdf_find_font():
    """返回可用的中文字体文件路径，找不到返回 None"""
    for p in _PDF_FONT_CANDIDATES:
        if os.path.exists(p):
            return p
    return None


def _pdf_fmt_zsbh(v):
    """证书编号按官方格式分组：18 位纯数字 -> 4-4-4-4-2 空格分隔"""
    v = (v or "").replace(" ", "")
    if v.isdigit() and len(v) == 18:
        return "%s %s %s %s %s" % (v[0:4], v[4:8], v[8:12], v[12:16], v[16:18])
    return v


def _pdf_fields(typ, info):
    """返回备案表字段 [(label, value)]，顺序与官方一致"""
    def g(k):
        return info.get(k) or ""
    if typ == "xj":
        return [
            ("姓名", g("xm")), ("性别", g("xb")), ("出生日期", g("csrq")),
            ("民族", g("mz")), ("学校名称", g("yxmc")), ("层次", g("cc")),
            ("专业", g("zymc")), ("学制", g("xz")), ("学历类别", g("xllb")),
            ("学习形式", g("xxxs")), ("分院", g("fy")), ("系所", g("xsh")),
            ("入学日期", g("rxrq")), ("学籍状态", g("xjzt")), ("离校日期", g("byrq")),
        ]
    return [
        ("姓名", g("xm")), ("性别", g("xb")), ("出生日期", g("csrq")),
        ("入学日期", g("rxrq")), ("毕（结）业日期", g("byrq")), ("学校名称", g("yxmc")),
        ("专业", g("zymc")), ("学制", g("xz")), ("层次", g("cc")),
        ("学历类别", g("xllb")), ("学习形式", g("xxxs")), ("毕（结）业", g("bjyjl")),
        ("证书编号", _pdf_fmt_zsbh(g("zsbh"))), ("校（院）长姓名", g("xzm")),
    ]


def _generate_report_pdf(typ, item, report, info):
    """按官方备案表样式生成 PDF，返回 bytes；失败返回 None。

    版面为 A4（595x842pt），逐项还原官方 PDF 的字体/字号/颜色/坐标：
    标题 21.5pt 黑色居中、字段 11.5pt（标签灰 #4C4C4C / 值黑）、
    更新日期 10pt 灰、在线验证码 15pt 链接色、注意事项 8pt。
    """
    try:
        import pymupdf
    except ImportError:
        try:
            import fitz as pymupdf
        except ImportError:
            return None
    from PIL import Image as _PILImage
    import io as _io
    font_path = _pdf_find_font()
    if not font_path:
        return None

    is_xj = (typ == "xj")
    title = "教育部学籍在线验证报告" if is_xj else "教育部学历证书电子注册备案表"
    verify_code = report.get("verifyCode") or ""
    valid_from = report.get("validFrom") or ""

    doc = pymupdf.open()
    page = doc.new_page(width=595, height=842)

    # 用真实字体度量计算宽度（含半角字符时 get_text_length 不支持自定义字体，len*size 会高估导致文字分太开）
    _font = pymupdf.Font(fontfile=font_path)

    def text_len(t, size):
        return _font.text_length(t, fontsize=size)

    # 1. 防伪底纹背景（转 JPEG 控制体积，官方为压缩存储）
    if os.path.exists(_PDF_BG_PATH):
        try:
            _bg = _PILImage.open(_PDF_BG_PATH).convert("RGB")
            _buf = _io.BytesIO()
            _bg.save(_buf, format="JPEG", quality=85, optimize=True)
            page.insert_image(pymupdf.Rect(0, 0, 595, 842), stream=_buf.getvalue())
        except Exception:
            pass

    # 注册中文字体
    fontname = "SC"
    try:
        page.insert_font(fontname=fontname, fontfile=font_path)
    except Exception:
        return None

    BLACK = (0, 0, 0)
    LABEL = (76 / 255.0, 76 / 255.0, 76 / 255.0)    # #4C4C4C
    GRAY = (153 / 255.0, 153 / 255.0, 153 / 255.0)  # #999999
    LINK = (0 / 255.0, 186 / 255.0, 199 / 255.0)    # #00BAC7 验证码/链接色

    # 2. 标题（居中，21.5pt 黑色）
    tw = text_len(title, 21.5)
    page.insert_text(((595 - tw) / 2.0, 66.6), title,
                     fontname=fontname, fontsize=21.5, color=BLACK)

    # 3. 更新日期（居中，10pt 灰色）
    update = "更新日期：" + valid_from
    uw = text_len(update, 10.0)
    page.insert_text(((595 - uw) / 2.0, 94.6), update,
                     fontname=fontname, fontsize=10.0, color=GRAY)

    # 4. 照片（右上角）
    if is_xj:
        photo_key = "lqPic" if _photo_exists(item.get("id"), "lqPic") else "xlPic"
    else:
        photo_key = "xlPic"
    photo_data = _read_photo(item.get("id"), photo_key)
    if photo_data:
        try:
            _im = _PILImage.open(_io.BytesIO(photo_data)).convert("RGB")
            _im = _im.resize((480, 640), _PILImage.LANCZOS)
            _buf = _io.BytesIO()
            _im.save(_buf, format="JPEG", quality=85, optimize=True)
            page.insert_image(pymupdf.Rect(455.5, 108.6, 535.0, 214.6), stream=_buf.getvalue())
        except Exception:
            pass

    # 5. 字段表格（标签灰、值黑，11.5pt，行距 26pt）
    base_y = 130.12
    row_h = 26.0
    for i, (label, value) in enumerate(_pdf_fields(typ, info)):
        y = base_y + i * row_h
        page.insert_text((60.0, y), label, fontname=fontname, fontsize=11.5, color=LABEL)
        page.insert_text((178.75, y), str(value), fontname=fontname, fontsize=11.5, color=BLACK)

    # 6. 在线验证码 / 验证网址 / 使用 App
    lx = 163.79
    page.insert_text((lx, 672.67), "在线验证码 ", fontname=fontname, fontsize=10.0, color=BLACK)
    cw = text_len("在线验证码 ", 10.0)
    page.insert_text((lx + cw, 672.67), verify_code,
                     fontname=fontname, fontsize=15.0, color=LINK)
    page.insert_text((lx, 688.67), "①验证报告在线查验网址：https://www.chsi.com.cn/xlcx/bgcx.jsp",
                     fontname=fontname, fontsize=10.0, color=BLACK)
    page.insert_text((lx, 704.67), "②使用学信网App扫描二维码验证",
                     fontname=fontname, fontsize=10.0, color=BLACK)

    # 7. 二维码（左下角，缩小 box_size 控制体积，deflate 后很小）
    try:
        import qrcode
        qr = qrcode.QRCode(border=2, box_size=4)
        qr.add_data("https://www.chsi.com.cn/xlcx/bgcx.jsp?verifyCode=%s" % verify_code)
        qr.make(fit=True)
        qimg = qr.make_image(fill_color="black", back_color="white").convert("RGB")
        buf = _io.BytesIO()
        qimg.save(buf, format="PNG")
        page.insert_image(pymupdf.Rect(76.96, 648.14, 144.82, 716.0), stream=buf.getvalue())
    except Exception:
        pass

    # 8. 学信网 logo（右下角）
    if os.path.exists(_PDF_LOGO_PATH):
        try:
            page.insert_image(pymupdf.Rect(502.2, 770.0, 563.0, 810.0), filename=_PDF_LOGO_PATH)
        except Exception:
            pass

    # 9. 注意事项（8pt，底部；第 1 条中间的「教学[2014]11号」为链接色）
    if is_xj:
        n1_prefix = "1、在线验证报告是依据《高等学校学生学籍学历电子注册办法》("
        n1_suffix = ")对学籍信息电子注册复核的结果。"
        notes = [
            "2、报告内容如有修改，请以最新在线验证的内容为准。",
            "3、未经学籍信息权属人同意，不得将报告用于违背权属人意愿之用途。",
            "4、报告在线验证有效期由报告权属人设置（1~6个月），其在报告验证到期前可再次延长验证有效期。",
        ]
    else:
        n1_prefix = "1、备案表是依据《高等学校学生学籍学历电子注册办法》("
        n1_suffix = ")对学历证书电子注册复核备案的结果。"
        notes = [
            "2、备案表内容如有修改，请以最新在线验证的内容为准。",
            "3、未经学历信息权属人同意，不得将备案表用于违背权属人意愿之用途。",
            "4、报告在线验证有效期由报告权属人设置（1~6个月），其在报告验证到期前可再次延长验证有效期。",
        ]
    page.insert_text((62.0, 740.0), "注意事项：", fontname=fontname, fontsize=8.0, color=BLACK)
    nx = 62.0
    page.insert_text((nx, 755.0), n1_prefix, fontname=fontname, fontsize=8.0, color=BLACK)
    nx += text_len(n1_prefix, 8.0)
    page.insert_text((nx, 755.0), "教学[2014]11号", fontname=fontname, fontsize=8.0, color=LINK)
    nx += text_len("教学[2014]11号", 8.0)
    page.insert_text((nx, 755.0), n1_suffix, fontname=fontname, fontsize=8.0, color=BLACK)
    for idx, nt in enumerate(notes):
        page.insert_text((62.0, 770.0 + idx * 15.0), nt,
                         fontname=fontname, fontsize=8.0, color=BLACK)

    # 字体子集化：只嵌入用到的字形，官方 PDF 即子集化（体积从 8MB 降到几十 KB）
    try:
        doc.subset_fonts()
    except Exception:
        pass
    return doc.tobytes(garbage=4, deflate=True, clean=True)


def get_local_account_by_current_user():
    """返回当前登录账号的本地维护数据；非本地账号（无密码）返回 None"""
    phone = get_current_user()
    if not phone:
        return None
    account = load_local_data().get("accounts", {}).get(phone, {})
    if account.get("password"):
        return account
    return None


def build_search_result(account):
    """根据本地维护数据构建 search.action 返回的学籍/学历列表（明文）"""
    xj_list = account.get("xj", []) or []
    xl_list = account.get("xl", []) or []

    def _xj_item(it):
        return {
            "id": it.get("id", ""),
            "yxmc": it.get("yxmc", ""),
            "cc": it.get("cc", ""),
            "zymc": it.get("zymc", ""),
            "xxxs": it.get("xxxs", ""),
        }

    def _xl_item(it):
        return {
            "id": it.get("id", ""),
            "yxmc": it.get("yxmc", ""),
            "cc": it.get("cc", ""),
            "zymc": it.get("zymc", ""),
            "xxxs": it.get("xxxs", ""),
            "xlzms": bool(it.get("xlzms", False)),
        }

    data = {
        "limit": False,
        "xj": {
            "exist": bool(xj_list),
            "amount": len(xj_list),
            "xm": (xj_list[0].get("xm") if xj_list else "") or "",
            "zjhm": (xj_list[0].get("sfzh") if xj_list else "") or "",
            "showZxsTips": False,
            "dataList": [_xj_item(it) for it in xj_list],
        },
        "xl": {
            "exist": bool(xl_list),
            "amount": len(xl_list),
            "xm": (xl_list[0].get("xm") if xl_list else "") or "",
            "zjhm": (xl_list[0].get("sfzh") if xl_list else "") or "",
            "dataList": [_xl_item(it) for it in xl_list],
        },
        "ky": {"exist": False, "amount": 0, "xm": "", "zjhm": "", "dataList": []},
        "xw": {"exist": False, "amount": 0, "xm": "", "zjhm": "", "dataList": []},
    }
    return {
        "flag": True,
        "data": data,
        "invokeStatus": "success",
        "errorMessage": "",
        "taskId": "",
    }


def cas_login(username, password):
    """执行学信网 CAS 登录流程，返回 (ok, cookies, archive_html, message)"""
    s = requests.Session()
    s.headers.update({
        "User-Agent": UA,
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
        "Accept-Language": "zh-CN,zh;q=0.9",
    })

    # 1. 获取登录页，拿 lt / execution / jsessionid
    try:
        r = s.get(LOGIN_URL, params={"service": SERVICE},
                  allow_redirects=True, timeout=30)
    except Exception as e:
        return False, {}, "", "获取登录页失败: %s" % e

    html = r.text
    lt_m = re.search(r'name="lt"\s+value="([^"]+)"', html)
    ex_m = re.search(r'name="execution"\s+value="([^"]+)"', html)
    form_m = re.search(r'<form id="fm1" action="([^"]+)"', html)

    if not (lt_m and ex_m):
        return False, {}, "", "获取登录令牌(lt/execution)失败"

    action = form_m.group(1) if form_m else "/passport/login"
    post_url = ("https://account.chsi.com.cn" + action
                if action.startswith("/") else action)

    data = {
        "username": username,
        "password": password,
        "lt": lt_m.group(1),
        "execution": ex_m.group(1),
        "_eventId": "submit",
    }
    headers = {
        "Referer": r.url,
        "Origin": "https://account.chsi.com.cn",
        "Content-Type": "application/x-www-form-urlencoded",
    }

    # 2. 提交登录表单（不自动跟随，观察 302）
    try:
        r2 = s.post(post_url, data=data, headers=headers,
                    allow_redirects=False, timeout=30)
    except Exception as e:
        return False, {}, "", "提交登录失败: %s" % e

    loc = r2.headers.get("Location")
    if r2.status_code not in (301, 302) or not loc:
        # 登录失败，尝试从响应里找错误提示
        err_m = re.search(r'<div[^>]*class="[^"]*errors[^"]*"[^>]*>(.*?)</div>',
                          r2.text, re.S)
        msg = re.sub(r"<[^>]+>", "", err_m.group(1)).strip() if err_m else "账号或密码错误"
        return False, {}, "", msg

    # 3. 跟随重定向（ticket 校验 → 建立档案域会话）
    url = loc
    final_html = ""
    for _ in range(5):
        if not url:
            break
        try:
            r3 = s.get(url, allow_redirects=False, timeout=30)
        except Exception as e:
            return False, {}, "", "跳转失败: %s" % e
        if r3.status_code in (301, 302) and r3.headers.get("Location"):
            url = r3.headers["Location"]
            continue
        final_html = r3.text
        break

    # 4. 最终请求档案页（确保拿到完整登录后数据）
    try:
        r4 = s.get(ARCHIVE_URL, timeout=30)
        if r4.status_code == 200:
            final_html = r4.text
    except Exception:
        pass

    cookies = {c.name: c.value for c in s.cookies}
    if not cookies.get("JSESSIONID") and not cookies.get("CASTGC"):
        return False, cookies, final_html, "登录未建立会话"

    # 保存 cookie 与登录后数据
    save_cookies(cookies)
    if final_html:
        STORE.write_text(KEY_ARCHIVE, final_html)

    return True, cookies, final_html, "登录成功"


def proxy_request(path, method="GET", body=b""):
    """用已保存 cookie 代理请求官方接口，返回 (status, content_type, bytes)"""
    cookies = load_cookies()
    if not cookies:
        return 401, "application/json; charset=utf-8", \
            json.dumps({"error": "未登录，请先调用 /api/login"}).encode("utf-8")

    # 归一化 URL：相对路径补官方域名，限定官方域名
    if path.startswith("http://") or path.startswith("https://"):
        url = path
    else:
        url = "https://my.chsi.com.cn" + (path if path.startswith("/") else "/" + path)

    host = urllib.parse.urlparse(url).netloc
    if not (host.endswith("chsi.com.cn") or host.endswith("chsi.cn")):
        return 403, "application/json; charset=utf-8", \
            json.dumps({"error": "仅允许访问学信网官方域名"}).encode("utf-8")

    s = requests.Session()
    s.cookies.update(cookies)
    s.headers.update({
        "User-Agent": UA,
        "Accept": "*/*",
        "X-Requested-With": "XMLHttpRequest",
        "Referer": "https://my.chsi.com.cn/archive/wap/index.action",
    })
    try:
        if method == "POST":
            s.headers["Content-Type"] = "application/x-www-form-urlencoded; charset=UTF-8"
            r = s.post(url, data=body, timeout=30)
        else:
            r = s.get(url, timeout=30)
    except Exception as e:
        return 502, "application/json; charset=utf-8", \
            json.dumps({"error": "请求官方接口失败: %s" % e}).encode("utf-8")

    ctype = r.headers.get("Content-Type", "text/html; charset=utf-8")
    return r.status_code, ctype, r.content


class Handler(http.server.SimpleHTTPRequestHandler):
    extensions_map = dict(http.server.SimpleHTTPRequestHandler.extensions_map)
    extensions_map['.jsp'] = 'text/html; charset=utf-8'
    extensions_map['.shtml'] = 'text/html; charset=utf-8'

    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIR, **kwargs)

    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        super().end_headers()

    def _send_json(self, obj, status=200):
        data = json.dumps(obj, ensure_ascii=False).encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def _api_login(self):
        length = int(self.headers.get("Content-Length", 0))
        body = self.rfile.read(length).decode("utf-8", "ignore")
        params = urllib.parse.parse_qs(body)
        username = (params.get("username") or [""])[0].strip()
        password = (params.get("password") or [""])[0]

        if not username or not password:
            return self._send_json({"success": False, "message": "用户名或密码不能为空"}, 400)

        # 本地维护优先：若该账号在本地维护了密码，则用本地密码验证，不请求官方
        local = load_local_data()
        account = local.get("accounts", {}).get(username)
        if account and account.get("password"):
            if account["password"] == password:
                set_current_user(username)
                return self._send_json({"success": True, "message": "本地验证登录成功", "local": True})
            return self._send_json({"success": False, "message": "您输入的用户名或密码有误。"}, 401)

        ok, cookies, archive_html, message = cas_login(username, password)
        if ok:
            set_current_user(username)
            self._send_json({
                "success": True,
                "message": message,
                "cookieCount": len(cookies),
                "cookieKeys": list(cookies.keys()),
                "archiveSize": len(archive_html),
            })
        else:
            self._send_json({"success": False, "message": message}, 401)

    def _api_archive(self):
        status, ctype, content = proxy_request("/archive/wap/index.action")
        self.send_response(status)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(content)))
        self.end_headers()
        self.wfile.write(content)

    def _api_proxy(self):
        parsed = urllib.parse.urlparse(self.path)
        qs = urllib.parse.parse_qs(parsed.query)
        url = (qs.get("url") or [""])[0]
        if not url:
            return self._send_json({"error": "缺少 url 参数"}, 400)
        status, ctype, content = proxy_request(url)
        self.send_response(status)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(content)))
        self.end_headers()
        self.wfile.write(content)

    def _api_cookies(self):
        cookies = load_cookies()
        self._send_json({"cookies": cookies, "count": len(cookies)})

    def _proxy_raw(self, full_path):
        status, ctype, content = proxy_request(full_path)
        self.send_response(status)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(content)))
        self.end_headers()
        self.wfile.write(content)

    def _serve_local_photo(self, parsed):
        """优先返回本地照片文件，未命中则代理官方图片接口。

        照片以独立文件存储在 session/photos/ 下，
        文件名形如 xj_xxx_lq.jpg / xj_xxx_xl.jpg，与维护记录 id 对应。
        """
        qs = urllib.parse.parse_qs(parsed.query)
        pid = (qs.get("pid") or [""])[0]
        key = _photo_key_from_path(parsed.path)
        data = _read_photo(pid, key) if pid else None
        if data:
            self.send_response(200)
            self.send_header("Content-Type", "image/jpeg")
            self.send_header("Content-Length", str(len(data)))
            # 照片会随时被后台维护修改，禁止长缓存，确保刷新后能看到最新照片
            self.send_header("Cache-Control", "no-cache, no-store, must-revalidate")
            self.send_header("Pragma", "no-cache")
            self.end_headers()
            self.wfile.write(data)
            return
        return self._proxy_raw(self.path)

    def _api_gdjy_detail(self):
        parsed = urllib.parse.urlparse(self.path)
        qs = urllib.parse.parse_qs(parsed.query)
        typ = (qs.get("type") or [""])[0]
        did = (qs.get("id") or [""])[0]
        if typ not in ("xj", "xl") or not did:
            return self._send_json({"error": "参数错误"}, 400)

        # 本地维护数据优先：若维护了当前登录账号，则不再请求官网
        phone = get_current_user()
        local = load_local_data()
        account = local.get("accounts", {}).get(phone, {})
        if typ == "xj" and account.get("xj"):
            for item in account["xj"]:
                if item.get("id") == did:
                    return self._send_json(
                        {"result": build_xj_result(item), "message": "", "status": 0})
        if typ == "xl" and account.get("xl"):
            for item in account["xl"]:
                if item.get("id") == did:
                    return self._send_json(
                        {"result": {"xl": build_xl_result(item),
                                    "xlfyzyList": [], "hasXlfzzy": False, "type": "ypcwk"},
                         "message": "", "status": 0})

        # 官方兜底：提取 resultJson 原始 JSON（保留 surrogate 转义，配合字体反爬）
        status, ctype, content = proxy_request(
            "/archive/wap/gdjy/%s/detail.action?id=%s" % (typ, did))
        if status != 200:
            return self._send_json({"error": "请求官方详情失败", "status": status}, status)
        html = content.decode("utf-8", "ignore")
        raw = extract_json_raw(html, "resultJson:")
        if not raw:
            return self._send_json({"error": "解析 resultJson 失败"}, 500)
        data = raw.encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def _api_gdjy_report(self):
        """返回本地维护的「在线验证报告」数据（学籍在线验证报告 / 学历电子注册备案表）"""
        parsed = urllib.parse.urlparse(self.path)
        qs = urllib.parse.parse_qs(parsed.query)
        typ = (qs.get("type") or [""])[0]
        did = (qs.get("id") or [""])[0]
        if typ not in ("xj", "xl") or not did:
            return self._send_json({"error": "参数错误"}, 400)

        phone = get_current_user()
        account = load_local_data().get("accounts", {}).get(phone, {})
        item = None
        if typ == "xj":
            for it in account.get("xj", []):
                if it.get("id") == did:
                    item = it
                    break
        else:
            for it in account.get("xl", []):
                if it.get("id") == did:
                    item = it
                    break
        if item is None:
            return self._send_json({"error": "未找到对应记录"}, 404)

        report = _ensure_report_fields(item, typ)
        base = build_xj_result(item) if typ == "xj" else build_xl_result(item)
        title = "教育部学籍在线验证报告" if typ == "xj" else "教育部学历证书电子注册备案表"
        state = _report_state(item, report)
        return self._send_json({
            "status": 0,
            "message": "",
            "result": {
                "type": typ,
                "title": title,
                "reportState": state,
                "info": base,
                "report": report,
            },
        })

    def _api_gdjy_report_pdf(self):
        """按官方备案表样式生成报告 PDF 并下载"""
        parsed = urllib.parse.urlparse(self.path)
        qs = urllib.parse.parse_qs(parsed.query)
        typ = (qs.get("type") or [""])[0]
        did = (qs.get("id") or [""])[0]
        if typ not in ("xj", "xl") or not did:
            return self._send_json({"error": "参数错误"}, 400)

        phone = get_current_user()
        account = load_local_data().get("accounts", {}).get(phone, {})
        item = None
        for it in (account.get(typ, []) or []):
            if it.get("id") == did:
                item = it
                break
        if item is None:
            return self._send_json({"error": "未找到对应记录"}, 404)

        report = _ensure_report_fields(item, typ)
        info = build_xj_result(item) if typ == "xj" else build_xl_result(item)
        pdf = _generate_report_pdf(typ, item, report, info)
        if not pdf:
            return self._send_json({"error": "PDF 生成失败（缺少 PyMuPDF 或中文字体）"}, 500)

        title = "教育部学籍在线验证报告" if typ == "xj" else "教育部学历证书电子注册备案表"
        fname = title + "_" + (item.get("xm") or "") + ".pdf"
        fname_enc = urllib.parse.quote(fname)
        self.send_response(200)
        self.send_header("Content-Type", "application/pdf")
        self.send_header("Content-Disposition",
                         "attachment; filename=\"report.pdf\"; filename*=UTF-8''%s" % fname_enc)
        self.send_header("Content-Length", str(len(pdf)))
        self.end_headers()
        self.wfile.write(pdf)

    def _api_gdjy_show(self):
        """返回当前账号「已申请的报告」列表（在线验证报告列表中间页）"""
        parsed = urllib.parse.urlparse(self.path)
        qs = urllib.parse.parse_qs(parsed.query)
        typ = (qs.get("type") or [""])[0]
        if typ not in ("xj", "xl"):
            return self._send_json({"error": "参数错误"}, 400)

        phone = get_current_user()
        account = load_local_data().get("accounts", {}).get(phone, {})
        items = account.get(typ, []) or []
        reports = []
        _status_map = {"valid": "有效", "closed": "已关闭", "expired": "已过期"}
        for it in items:
            r = _ensure_report_fields(it, typ)
            valid_to = r.get("validTo", "")
            # 官方表格有效期显示 yyyy-MM-dd
            try:
                dt = datetime.datetime.strptime(valid_to, "%Y年%m月%d日")
                valid_to = dt.strftime("%Y-%m-%d")
            except Exception:
                pass
            reports.append({
                "id": it.get("id"),
                "verifyCode": r.get("verifyCode", ""),
                "reportNo": r.get("reportNo", ""),
                "lang": "中文",
                "validTo": valid_to,
                "status": _status_map.get(_report_state(it, r), "有效"),
            })
        title = "学籍在线验证报告" if typ == "xj" else "学历证书电子注册备案表"
        # 报告列表页顶部标题：层次-院校-专业（如 专科-信阳学院-汉语言文学）
        head_title = ""
        if items:
            first = items[0]
            parts = [str(first.get("cc", "")), str(first.get("yxmc", "")), str(first.get("zymc", ""))]
            parts = [p for p in parts if p]
            if parts:
                head_title = "-".join(parts)
        return self._send_json({
            "status": 0,
            "message": "",
            "result": {"type": typ, "title": title, "headTitle": head_title, "list": reports},
        })

    def _api_gdjy_report_action(self):
        """报告列表页操作：action=close 关闭报告 / action=extend 延长验证有效期"""
        length = int(self.headers.get("Content-Length", 0))
        body = self.rfile.read(length).decode("utf-8", "ignore")
        params = urllib.parse.parse_qs(body)
        typ = (params.get("type") or [""])[0].strip()
        did = (params.get("id") or [""])[0].strip()
        action = (params.get("action") or [""])[0].strip()
        if typ not in ("xj", "xl") or not did or action not in ("close", "extend"):
            return self._send_json({"success": False, "message": "参数错误"}, 400)

        phone = get_current_user()
        local = load_local_data()
        account = local.setdefault("accounts", {}).setdefault(phone, {"xj": [], "xl": []})
        lst = account.setdefault(typ, [])
        item = None
        for it in lst:
            if it.get("id") == did:
                item = it
                break
        if item is None:
            return self._send_json({"success": False, "message": "未找到对应报告"}, 404)

        if action == "close":
            item["reportStatus"] = "已关闭"
        else:
            # 延长有效期：清除关闭状态，有效期顺延 183 天
            item.pop("reportStatus", None)
            item["validTo"] = (datetime.date.today() + datetime.timedelta(days=183)).strftime("%Y年%m月%d日")

        save_local_data(local)
        return self._send_json({"success": True, "message": "操作成功"})

    def _api_admin_list(self):
        parsed = urllib.parse.urlparse(self.path)
        qs = urllib.parse.parse_qs(parsed.query)
        phone = (qs.get("phone") or [""])[0].strip()
        local = load_local_data()
        accounts = local.get("accounts", {})
        if phone:
            account = accounts.get(phone, {})
            return self._send_json({"phone": phone, "xj": account.get("xj", []),
                                    "xl": account.get("xl", [])})
        return self._send_json({"accounts": accounts})

    def _api_admin_save(self):
        length = int(self.headers.get("Content-Length", 0))
        body = self.rfile.read(length).decode("utf-8", "ignore")
        # keep_blank_values=True：前端「清除照片」会提交 lqPic= 这类空值，
        # 默认 parse_qs 会丢弃空值导致照片无法删除，必须保留空值以区分「未提交」与「清空」
        params = urllib.parse.parse_qs(body, keep_blank_values=True)
        phone = (params.get("phone") or [""])[0].strip()
        typ = (params.get("type") or [""])[0].strip()
        index = (params.get("index") or [""])[0].strip()
        if not phone or typ not in ("xj", "xl"):
            return self._send_json({"success": False, "message": "手机号或类型错误"}, 400)

        fields = XJ_FIELDS if typ == "xj" else XL_FIELDS
        item = {}
        for f in fields:
            v = (params.get(f) or [""])[0]
            if v:
                item[f] = v

        local = load_local_data()
        accounts = local.setdefault("accounts", {})
        account = accounts.setdefault(phone, {"xj": [], "xl": []})
        lst = account.setdefault(typ, [])

        # 编辑时定位旧记录，用于继承 id 与未重新上传的照片
        old = None
        edit_idx = None
        if index and index.isdigit():
            edit_idx = int(index)
            if 0 <= edit_idx < len(lst):
                old = lst[edit_idx]

        # id 处理：编辑继承旧 id（前端不提交 id，避免 id 变化导致照片文件引用失效）；仅新增生成新 id
        if old and old.get("id"):
            item["id"] = old["id"]
        if not item.get("id"):
            import uuid
            item["id"] = typ + "_" + uuid.uuid4().hex[:16]

        # 照片字段：新照片(dataURL)写文件；沿用旧照片(URL)纠正 pid 并迁移文件；空值删文件；未提交继承旧值
        for pf in ("lqPic", "xlPic"):
            if pf in params:
                v = (params.get(pf) or [""])[0]
                if v.startswith("data:"):
                    mime, data = _decode_dataurl(v)
                    if data:
                        _write_photo(item["id"], pf, _maybe_compress(data))
                        item[pf] = _photo_url(item["id"], pf)
                elif v.startswith("/archive/photo/"):
                    _keep_photo(item, pf, _pid_from_photo_url(v))
                else:
                    # 空字符串等：删除照片文件
                    _delete_photo(item["id"], pf)
            elif old and old.get(pf):
                old_pid = _pid_from_photo_url(old[pf]) if isinstance(old.get(pf), str) else ""
                _keep_photo(item, pf, old_pid)

        # 报告字段：缺失时自动生成默认值并持久化，后台可再手动修改
        _ensure_report_fields(item, typ)

        if edit_idx is not None and 0 <= edit_idx < len(lst):
            lst[edit_idx] = item
        else:
            lst.append(item)
        save_local_data(local)
        return self._send_json({"success": True, "message": "保存成功", "item": item})

    def _api_admin_delete(self):
        length = int(self.headers.get("Content-Length", 0))
        body = self.rfile.read(length).decode("utf-8", "ignore")
        params = urllib.parse.parse_qs(body)
        phone = (params.get("phone") or [""])[0].strip()
        typ = (params.get("type") or [""])[0].strip()
        index = (params.get("index") or [""])[0].strip()
        if not phone or typ not in ("xj", "xl") or not index.isdigit():
            return self._send_json({"success": False, "message": "参数错误"}, 400)
        local = load_local_data()
        account = local.get("accounts", {}).get(phone, {})
        lst = account.get(typ, [])
        i = int(index)
        if 0 <= i < len(lst):
            removed = lst.pop(i)
            for pf in ("lqPic", "xlPic"):
                _delete_photo(removed.get("id"), pf)
            save_local_data(local)
            return self._send_json({"success": True, "message": "删除成功"})
        return self._send_json({"success": False, "message": "索引越界"}, 400)

    def _api_admin_account_save(self):
        """创建/更新账号密码"""
        length = int(self.headers.get("Content-Length", 0))
        body = self.rfile.read(length).decode("utf-8", "ignore")
        params = urllib.parse.parse_qs(body)
        phone = (params.get("phone") or [""])[0].strip()
        password = (params.get("password") or [""])[0]
        if not phone:
            return self._send_json({"success": False, "message": "手机号不能为空"}, 400)
        local = load_local_data()
        accounts = local.setdefault("accounts", {})
        account = accounts.setdefault(phone, {"xj": [], "xl": []})
        account["password"] = password
        account.setdefault("xj", [])
        account.setdefault("xl", [])
        save_local_data(local)
        return self._send_json({"success": True, "message": "保存成功"})

    def _api_admin_account_delete(self):
        """删除账号（含其全部学籍学历数据）"""
        length = int(self.headers.get("Content-Length", 0))
        body = self.rfile.read(length).decode("utf-8", "ignore")
        params = urllib.parse.parse_qs(body)
        phone = (params.get("phone") or [""])[0].strip()
        if not phone:
            return self._send_json({"success": False, "message": "手机号不能为空"}, 400)
        local = load_local_data()
        accounts = local.get("accounts", {})
        if phone in accounts:
            account = accounts.pop(phone)
            for typ in ("xj", "xl"):
                for item in account.get(typ, []):
                    for pf in ("lqPic", "xlPic"):
                        _delete_photo(item.get("id"), pf)
            save_local_data(local)
            return self._send_json({"success": True, "message": "删除成功"})
        return self._send_json({"success": False, "message": "账号不存在"}, 404)

    def do_POST(self):
        parsed = urllib.parse.urlparse(self.path)
        if parsed.path == "/api/login":
            return self._api_login()
        if parsed.path == "/api/admin/save":
            return self._api_admin_save()
        if parsed.path == "/api/admin/delete":
            return self._api_admin_delete()
        if parsed.path == "/api/admin/account/save":
            return self._api_admin_account_save()
        if parsed.path == "/api/admin/account/delete":
            return self._api_admin_account_delete()
        if parsed.path == "/api/gdjy/report/action":
            return self._api_gdjy_report_action()
        # 本地登录模式：本地维护账号不请求官方，直接返回本地 mock
        account = get_local_account_by_current_user()
        if account is not None:
            if parsed.path == "/archive/ncss/zwtj/query.action":
                return self._send_json({"result": None, "message": "", "status": 1})
            if parsed.path == "/archive/wap/rcd.action":
                return self._send_json({
                    "flag": True,
                    "data": {
                        "data": {
                            "surveyUrl": "https://xz.chsi.com.cn/cp/jump/cover.do?surveyId=h383nry7hky4xrbr&from=",
                            "imageUrl": "/archive/images/xzpt/hygl.png",
                            "surveyDesc": "会议管理能力测试",
                            "finished": False,
                            "title": "会议管理能力测试",
                        },
                        "type": "xzcp",
                    },
                    "invokeStatus": "success",
                    "errorMessage": "",
                    "taskId": "",
                })
            if parsed.path == "/archive/survey/zswj/show.action":
                length = int(self.headers.get("Content-Length", 0))
                body = self.rfile.read(length).decode("utf-8", "ignore")
                params = urllib.parse.parse_qs(body)
                position = (params.get("position") or [""])[0]
                survey_one = {
                    "wap_main": "zcsx",
                    "wap_xjxl": "zytj",
                    "wap_txjd": "zcsx",
                }.get(position, "")
                return self._send_json({
                    "result": {
                        "surveyTwo": "",
                        "id": "",
                        "surveyOne": survey_one,
                        "jySurvey": "",
                        "key": "",
                    },
                    "message": "",
                    "status": 0,
                })
            if parsed.path == "/archive/wap/gdjy/search.action":
                return self._send_json(build_search_result(account))
            if parsed.path == "/archive/wap/gdjy/zp/zzk/check.action":
                # 本地维护模式：照片由本地文件提供，无「找找看」比对，返回不可用，避免代理官方报错
                return self._send_json({
                    "result": {
                        "zzkAvaliable": False,
                        "photoInfoExist": False,
                        "hasChoosed": False,
                        "choosedResult": 0,
                    },
                    "message": "",
                    "status": 0,
                })
        length = int(self.headers.get("Content-Length", 0))
        body = self.rfile.read(length)
        status, ctype, content = proxy_request(parsed.path, "POST", body)
        self.send_response(status)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(content)))
        self.end_headers()
        self.wfile.write(content)

    def do_GET(self):
        parsed = urllib.parse.urlparse(self.path)
        if parsed.path == "/api/archive":
            return self._api_archive()
        if parsed.path == "/api/proxy":
            return self._api_proxy()
        if parsed.path == "/api/cookies":
            return self._api_cookies()
        if parsed.path == "/api/gdjy/detail":
            return self._api_gdjy_detail()
        if parsed.path == "/api/gdjy/report":
            return self._api_gdjy_report()
        if parsed.path == "/api/gdjy/report/pdf":
            return self._api_gdjy_report_pdf()
        if parsed.path == "/api/gdjy/show":
            return self._api_gdjy_show()
        if parsed.path == "/api/admin/list":
            return self._api_admin_list()
        # 本地维护照片：录取照片/学历照片，优先返回本地，否则代理官方
        if parsed.path in ("/archive/photo/lqpic.do", "/archive/photo/xjpic.do",
                           "/archive/photo/xlpic.do"):
            return self._serve_local_photo(parsed)
        # 代理官方动态接口（图片 / 数据），携带 cookie
        if parsed.path.startswith("/archive/") and \
                (parsed.path.endswith(".action") or parsed.path.endswith(".do")):
            return self._proxy_raw(self.path)
        return super().do_GET()

    def log_message(self, format, *args):
        print("[%s] %s" % (self.log_date_time_string(), format % args))


class ThreadingHTTPServer(socketserver.ThreadingTCPServer):
    # 允许快速重启（端口占用 TIME_WAIT 时仍可绑定）
    allow_reuse_address = True
    daemon_threads = True


def migrate_photos_to_files():
    """把 local_data.json 内嵌的 base64 照片迁移为独立文件，item 改存 URL，避免 JSON 巨大。

    迁移不压缩（保持原图质量）；之后新上传的照片会走压缩。
    """
    local = load_local_data()
    changed = False
    for account in local.get("accounts", {}).values():
        for typ in ("xj", "xl"):
            for item in account.get(typ, []):
                iid = item.get("id")
                if not iid:
                    continue
                for pf in ("lqPic", "xlPic"):
                    v = item.get(pf)
                    if isinstance(v, str) and v.startswith("data:"):
                        mime, data = _decode_dataurl(v)
                        if data:
                            _write_photo(iid, pf, data)
                            item[pf] = _photo_url(iid, pf)
                            changed = True
    if changed:
        save_local_data(local)


def align_photo_pids():
    """修复历史遗留的照片关联断裂：记录 id 与照片 URL 里的 pid 不一致时，
    把照片文件迁移到当前 id，并把 URL 统一为当前 id。

    背景：早期版本编辑记录时 id 会漂移，导致 local_data.json 里 lqPic/xlPic 的
    pid 与记录 id 不一致。前台详情页用记录 id 判断照片是否存在并渲染图片，
    pid 不一致时该照片就会「消失」（admin 页直接用 URL 所以还能显示）。
    """
    local = load_local_data()
    changed = False
    for account in local.get("accounts", {}).values():
        for typ in ("xj", "xl"):
            for item in account.get(typ, []):
                iid = item.get("id")
                if not iid:
                    continue
                for pf in ("lqPic", "xlPic"):
                    v = item.get(pf)
                    if not isinstance(v, str) or not v.startswith("/archive/photo/"):
                        continue
                    pid = _pid_from_photo_url(v)
                    if not pid or pid == iid:
                        continue
                    # pid 与 id 不一致：优先把 pid 文件迁移到 id
                    if _photo_exists(pid, pf):
                        _write_photo(iid, pf, _read_photo(pid, pf))
                        _delete_photo(pid, pf)
                        item[pf] = _photo_url(iid, pf)
                        changed = True
                    elif _photo_exists(iid, pf):
                        # id 文件已存在，仅纠正 URL
                        item[pf] = _photo_url(iid, pf)
                        changed = True
    if changed:
        save_local_data(local)


if __name__ == '__main__':
    HOST = os.environ.get("HOST", "0.0.0.0")
    migrate_photos_to_files()
    align_photo_pids()
    with ThreadingHTTPServer((HOST, PORT), Handler) as httpd:
        print("=" * 60)
        print("学信网本地站点已启动")
        print("监听: %s:%d" % (HOST, PORT))
        print("session 目录: %s" % SESSION_DIR)
        print("访问地址: http://127.0.0.1:%d/wap/index.jsp" % PORT)
        print("登录接口: POST /api/login  (username, password)")
        print("档案接口: GET  /api/archive")
        print("代理接口: GET  /api/proxy?url=/archive/gdjy/xj/show.action")
        print("按 Ctrl+C 停止")
        print("=" * 60)
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\n服务器已停止")
