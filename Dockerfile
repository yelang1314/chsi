FROM python:3.11-slim

WORKDIR /app

# 中文字体：在线验证报告 PDF 需要 CJK 字体，容器里缺字体会渲染成方块
RUN apt-get update \
    && apt-get install -y --no-install-recommends fonts-wqy-zenhei fonts-noto-cjk \
    && rm -rf /var/lib/apt/lists/*

# 先安装依赖（利用 Docker 层缓存）
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# 再拷贝项目文件
COPY . .

# session 目录被 .dockerignore 排除（含真实 cookie），这里重建并放开写权限：
# Spaces / Koyeb 的容器常以非 root 用户运行，/app 默认不可写
RUN mkdir -p /app/session && chmod -R 777 /app/session

# 云平台统一用 7860（Hugging Face Spaces / Render / Koyeb）；
# 微信云托管等需要 80 的环境用 -e PORT=80 覆盖即可
ENV PORT=7860
ENV HOST=0.0.0.0
# 有持久盘挂载到 /data 时自动用 /data/session，否则回退到 /app/session
ENV DATA_DIR=/data

EXPOSE 7860

CMD ["python", "server.py"]
