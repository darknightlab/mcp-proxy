FROM ghcr.io/sparfenyuk/mcp-proxy:latest

RUN apk add --no-cache nodejs npm

RUN python3 -m ensurepip && pip install --no-cache-dir uv

ENV PATH="/usr/local/bin:$PATH" \
    UV_PYTHON_PREFERENCE=only-system

ENTRYPOINT [ "mcp-proxy" ]