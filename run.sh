#!/bin/bash
# VideoTranscribe — 通用入口
# 适用于任何 AI Agent（Claude Code / OpenClaw / Codex / 命令行）
#
# 用法：
#   ./run.sh --input "video.mp4"
#   ./run.sh --input "https://youtu.be/xxx"
#   ./run.sh --input "video.mp4" --engine mlx
#   ./run.sh --input "video.mp4" --output ~/Desktop/result.txt

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 加载 Gemini API Key（兼容 PAI 的 api-registry）
if [ -f "$HOME/.shared-skills/api-registry/.env" ]; then
    export $(grep GEMINI_API_KEY "$HOME/.shared-skills/api-registry/.env" | xargs) 2>/dev/null
fi

python3 "$SCRIPT_DIR/Tools/transcribe.py" "$@"
