# -*- coding: utf-8 -*-
"""Vercel 入口。

Vercel 的 Python Runtime 支持在 api/*.py 里导出 `class handler(BaseHTTPRequestHandler)`，
所以这里不重写任何业务逻辑，直接把 server.Handler 继承过来复用。

唯一要处理的是路径：vercel.json 把**所有**请求 rewrite 到 /api/index，
原始路径通过 ?__path= 带进来，这里还原回 self.path，
后面的路由分发（/api/login、/wap/index.jsp、/archive/photo/*.do …）就完全照旧。
"""
import os
import sys
from urllib.parse import urlsplit, urlunsplit, parse_qsl, urlencode

# 让 api/index.py 能 import 到项目根目录的 server.py
_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
if _ROOT not in sys.path:
    sys.path.insert(0, _ROOT)

from server import Handler as _BaseHandler  # noqa: E402


class handler(_BaseHandler):

    def parse_request(self):
        ok = super().parse_request()
        if ok:
            self._restore_original_path()
        return ok

    def _restore_original_path(self):
        """把 /api/index?__path=/wap/index.jsp&foo=1 还原成 /wap/index.jsp?foo=1"""
        parts = urlsplit(self.path)
        if "__path" not in parts.query:
            return  # 直接命中 /api/* 的请求，原样使用
        original = None
        rest = []
        for key, value in parse_qsl(parts.query, keep_blank_values=True):
            if key == "__path" and original is None:
                original = value
            else:
                rest.append((key, value))
        if not original:
            return
        if not original.startswith("/"):
            original = "/" + original
        self.path = urlunsplit(("", "", original, urlencode(rest), ""))
