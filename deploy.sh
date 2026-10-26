#!/usr/bin/env bash
set -euo pipefail
# OpenCode 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://opencode.ai/v2/docs
# 更新日期：2026-10-26
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }

mkdir -p .download
cd .download

curl -fsSL https://opencode.ai/v2/install | bash
export PATH="$HOME/.opencode/bin:$PATH"
command -v opencode >/dev/null 2>&1 || { echo "安装后没找到 opencode，请把 ~/.opencode/bin 加入 PATH"; exit 1; }
opencode --version

echo ""

echo "安装完成：进入项目目录运行 opencode，先登录或配置模型供应商，再开始对话"
echo "若结果异常或需要改配置，请参考官方文档：https://opencode.ai/v2/docs"
