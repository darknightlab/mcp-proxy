From ghcr.io/astral-sh/uv:0.7.2-python3.12-bookworm

WORKDIR /app

RUN uv tool install git+https://github.com/sparfenyuk/mcp-proxy

RUN apt-get update && apt-get install -y --no-install-recommends curl && \
    curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
    apt-get install -y nodejs && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget git net-tools iputils-ping iproute2 dnsutils unzip zip \
    x11vnc xvfb fluxbox supervisor openssh-server \
    ca-certificates telnet && \
    rm -rf /var/lib/apt/lists/* && \
    curl nxtrace.org/nt |bash


ENV PATH="/root/.local/bin:$PATH" \
    RESOLUTION=1280x800x24

COPY entrypoint.sh ./
RUN chmod +x entrypoint.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY sshd_config /etc/ssh/sshd_config

ENTRYPOINT [ "./entrypoint.sh" ]
