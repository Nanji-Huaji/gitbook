FROM oven/bun:1.2.15-debian

WORKDIR /app

# 安装 Node.js (需要 >= 22.3)
RUN apt-get update && apt-get install -y curl \
    && curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# 复制所有源代码（包括 workspace 的 package.json）
COPY . .

# 安装依赖
RUN bun install

# 构建应用
RUN bun run build || true

EXPOSE 3000

CMD ["bun", "run", "dev"]
