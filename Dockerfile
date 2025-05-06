From ghcr.io/astral-sh/uv:0.7.2-python3.12-bookworm

WORKDIR /app

RUN uv tool install git+https://github.com/sparfenyuk/mcp-proxy

RUN apt-get update && apt-get install -y --no-install-recommends nodejs npm && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh ./
RUN chmod +x entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]
