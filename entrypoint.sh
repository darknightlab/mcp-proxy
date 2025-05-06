#!/bin/sh

# 启用此选项，如果脚本中的任何命令失败，脚本将立即退出。
# 如果 PRE_COMMAND 失败不应导致退出，请移除此行或在 PRE_COMMAND 后添加 || true
set -e

# 1. 如果环境变量 PRE_COMMAND 存在且非空，则执行这个 COMMAND
if [ -n "$PRE_COMMAND" ]; then
  echo "Executing PRE_COMMAND: $PRE_COMMAND"
  # 使用 sh -c 来执行命令字符串。这通常比直接使用 eval 更安全。
  # 它会在一个新的 shell 进程中执行命令。
  sh -c "$PRE_COMMAND"
  # 或者，如果 PRE_COMMAND 保证是一个简单的命令且不需要复杂的 shell 解析，
  # 并且您信任其内容，可以考虑直接执行（但不推荐用于任意字符串）：
  # $PRE_COMMAND
  # 或者，如果 PRE_COMMAND 包含需要在当前 shell 上下文执行的复杂 shell 语法 (并且你信任它):
  # eval "$PRE_COMMAND"
  echo "PRE_COMMAND finished."
fi

# 2. 接下来使用 mcp-proxy 并接收 entrypoint 收到的所有参数
# 使用 exec 会让 mcp-proxy 进程替换当前的 shell 进程。
# 这意味着 mcp-proxy 会成为容器的主进程 (PID 1)，能够正确处理信号。
echo "Executing mcp-proxy with arguments: $@"
exec mcp-proxy "$@"