From ghcr.io/astral-sh/uv:0.7.2-python3.12-bookworm

WORKDIR /app

RUN uv tool install git+https://github.com/sparfenyuk/mcp-proxy

RUN apt-get update && apt-get install -y --no-install-recommends curl && \
    curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
    apt-get install -y nodejs && rm -rf /var/lib/apt/lists/*

ENV PATH="/root/.local/bin:$PATH"

COPY entrypoint.sh ./
RUN chmod +x entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]
