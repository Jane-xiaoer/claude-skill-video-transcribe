# 视频转文字工具（VideoTranscribe）

> AI 驱动的视频/音频转录工具。有字幕抓字幕，没字幕用 AI 听写——YouTube、B站、本地文件全支持。

## 功能

- **本地文件转录**：MP4、MOV、MP3、M4A 等，ffmpeg 自动提音频
- **URL 转录**：YouTube、B站、小宇宙，任何 yt-dlp 支持的平台
- **字幕优先策略**：有字幕直接抓（快速、0 API 消耗），没有才下音频转录
- **两种引擎**：Gemini 2.5 Flash（有标点、推荐）/ mlx-whisper（本地离线）
- **内容提炼**：三种模式——快速摘要 / 结构化笔记 / 内容再创作

## 快速开始

```bash
# 转录本地视频
python3 Tools/transcribe.py --input "video.mp4"

# 转录 YouTube 视频
python3 Tools/transcribe.py --input "https://youtu.be/xxx"

# 转录 B站视频
python3 Tools/transcribe.py --input "https://www.bilibili.com/video/BVxxx"

# 使用本地 mlx-whisper（离线）
python3 Tools/transcribe.py --input "video.mp4" --engine mlx

# 指定输出路径
python3 Tools/transcribe.py --input "video.mp4" --output ~/Desktop/result.txt
```

## 依赖安装

```bash
# 必需
pip3 install google-genai    # Gemini 引擎（推荐）
brew install yt-dlp ffmpeg   # 音频处理

# 可选（本地离线引擎）
pip3 install mlx-whisper     # 仅 Apple Silicon
```

## API Key 配置

Gemini 引擎需要 API Key，从 [Google AI Studio](https://aistudio.google.com/) 免费申请：

```bash
# 方式一：环境变量
export GEMINI_API_KEY="your-key"

# 方式二：写入文件（PAI 用户推荐）
echo 'GEMINI_API_KEY=your-key' >> ~/.shared-skills/api-registry/.env
```

## 引擎对比

| 引擎 | 命令 | 优点 | 缺点 |
|------|------|------|------|
| `gemini`（默认）| `--engine gemini` | 有标点、可读性好、速度快 | 需网络 + API Key |
| `mlx` | `--engine mlx` | 完全离线、免费 | 无标点、仅 Apple Silicon |

## 接入各类 AI Agent

### 直接调用（所有平台通用）

任何 AI Agent 只需运行 `run.sh` 或直接调 Python 脚本：

```bash
# 通用入口（推荐）
bash /path/to/VideoTranscribe/run.sh --input "video.mp4"

# 或直接调脚本
python3 /path/to/VideoTranscribe/Tools/transcribe.py --input "video.mp4"
```

### Claude Code

将此目录放入 `~/.shared-skills/`，直接用自然语言触发：

> "帮我把这个视频转成文字"
> "把这个 YouTube 链接的内容转录出来"

### OpenClaw / Codex / Gemini CLI

在 agent 的工具调用或 bash 执行里直接写：

```bash
bash ~/.shared-skills/VideoTranscribe/run.sh --input "{{ input_url_or_path }}"
```

脚本会自动加载 Gemini API Key 并返回转录结果。

## 文件结构

```
VideoTranscribe/
├── SKILL.md              # Claude Code skill 入口
├── Workflows/
│   ├── Transcribe.md     # 转录流程
│   └── Extract.md        # 提炼流程（3种模式）
└── Tools/
    └── transcribe.py     # 核心脚本
```

## License

MIT
