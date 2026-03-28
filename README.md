# openCursor: TurboQuant AI Station for M3 Max 🍎🚀

[English](#english) | [中文](#chinese)

---

<a name="english"></a>
## English Version

### 🌟 Project Overview
This repository provides a high-performance, fully local AI-assisted programming environment optimized for **Apple M3 Max (36GB+ VRAM)**.

### ✨ Key Features
*   **KV Cache Compression**: Integrated with `TurboQuant+` (4x KV compression) to handle large 27B parameter models with a 32k+ context window without lag.
*   **Reasoning-First Intelligence**: Default deployment of `Qwen3.5-27B-Claude-4.6-Opus-Reasoning-Distilled` for elite code logic and refactoring.
*   **100% Privacy**: Offline execution, zero subscription fees, and no data leaks.
*   **IDE Integration**: Full support for `VS Code` + `Continue.dev` with `Cmd+I` refactoring and automatic file creation.

### 🛠️ Prerequisites
*   **Hardware**: Apple Silicon (M2/M3 Max with 36GB+ Unified Memory recommended).
*   **Software**: 
    *   [Ollama](https://ollama.com/)
    *   [Homebrew](https://brew.sh/)
    *   VS Code + [Continue Extension](https://www.continue.dev/)

### 🚀 Quick Start
1.  **Run Setup**:
    ```bash
    chmod +x setup_env.sh
    ./setup_env.sh
    ```
2.  **Start Server**: Run `~/start_ai_server.sh` or double-click the `TurboQuant_Start.command` on your desktop.
3.  **Config IDE**: Copy the template from `docs/continue_config.yaml` into your `.continue/config.yaml`.

---

<a name="chinese"></a>
## 中文版

### 🌟 项目简介
本项目为 **Apple M3 Max (36GB+ 显存)** 提供了高性能、全本地化的 AI 辅助编程工作站方案。

### ✨ 核心特性
*   **KV 缓存压缩**：集成 `TurboQuant+` (4x KV 压缩)，让 27B 参数大模型在 32k+ 上下文下依然流畅运行。
*   **推理级智能**：默认部署 `Qwen3.5-27B-Claude-4.6-Opus-Reasoning-Distilled`，提供顶尖的代码逻辑重构能力。
*   **100% 隐私安全**：离线运行，0 订阅费，数据不出机。
*   **IDE 深度集成**：适配 `VS Code` + `Continue.dev`，支持 `Cmd+I` 自动重构与全自动文件创建。

### 🛠️ 环境要求
*   **硬件**：Apple Silicon (推荐 M2/M3 Max，显存建议 36GB 及以上)。
*   **软件**：
    *   [Ollama](https://ollama.com/)
    *   [Homebrew](https://brew.sh/)
    *   VS Code + [Continue 插件](https://www.continue.dev/)

### 🚀 快速部署
1.  **一键安装**：
    ```bash
    chmod +x setup_env.sh
    ./setup_env.sh
    ```
2.  **启动服务**：终端运行 `~/start_ai_server.sh` 或双击桌面 `TurboQuant_Start.command` 图标。
3.  **集成配置**：将 `docs/continue_config.yaml` 中的模板复制到您的 `.continue/config.yaml`。

---
*Maintained by bennix and the openCursor community.*
