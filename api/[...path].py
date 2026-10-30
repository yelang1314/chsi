# -*- coding: utf-8 -*-
"""Vercel 通配入口：/api/* 由本文件处理，其余静态文件由 server.Handler 直接读盘返回。

不用 vercel.json 的 rewrite 把全站转到函数 —— Vercel 会把 rewrite 的 destination
当成函数看到的路径，原始路径丢失。这里直接用 catch-all 文件名（[...path]）拿到原路径。

照片接口的 URL 前缀会被改成 /api/photo（静态托管下 /archive/photo 不进函数），
请求进来后再映射回 /archive/photo 交给 server.Handler。
"""
import os
import sys
from urllib.parse import urlsplit, urlunsplit

_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
if _ROOT not in sys.path:
    sys.path.insert(0, _ROOT)

import server  # noqa: E402
from server import Handler as _BaseHandler  # noqa: E402

server.PHOTO_URL_PREFIX = "/api/photo"

_PHOTO_IN = "/api/photo/"
_PHOTO_OUT = "/archive/photo/"


class handler(_BaseHandler):

    def parse_request(self):
        ok = super().parse_request()
        if ok:
            self._remap_photo_path()
        return ok

    def _remap_photo_path(self):
        parts = urlsplit(self.path)
        if not parts.path.startswith(_PHOTO_IN):
            return
        tail = parts.path[len(_PHOTO_IN):]
        self.path = urlunsplit(("", "", _PHOTO_OUT + tail, parts.query, ""))
