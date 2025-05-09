#!/bin/bash

# 设置 root 密码
echo "root:${ROOT_PASSWORD}" | chpasswd

if [ -x /app/scripts/run.sh ]; then
    echo "[INFO] Running user script: /app/scripts/run.sh"
    /app/scripts/run.sh
else
    echo "[INFO] No init script found at /app/scripts/run.sh, skipping."
fi

# 启动 Supervisor
exec /usr/bin/supervisord -n