#!/bin/bash

# ==============================================================================
# openCursor - TurboQuant AI Setup Script (M3 Max optimized)
# 一键自动部署脚本 (M3 Max 专用)
# Function: Build TurboQuant, Pull Models, & Config Continue.dev
# 功能：自动编译引擎、下载模型并配置相关插件
# ==============================================================================

set -e

# 1. Variables / 变量定义
INSTALL_ROOT="$HOME/src"
MODEL_BLOBS="$HOME/.ollama/models/blobs"
CONFIG_PATH="$HOME/.continue/config.yaml"
PROJECT_NAME="turboquant"
REPO_URL="https://github.com/TheTom/llama-cpp-turboquant.git"
BRANCH="feature/turboquant-kv-cache"

echo "🌟 Starting Deployment / 开始部署 TurboQuant AI Station..."

# 2. Dependency Check / 检查依赖
if ! command -v cmake &> /dev/null || ! command -v git &> /dev/null; then
  echo "❌ Missing cmake or git. Please run: brew install cmake git"
  echo "❌ 缺少 cmake 或 git。请运行: brew install cmake git"
  exit 1
fi

if ! command -v ollama &> /dev/null; then
  echo "⚠️ Ensure Ollama is installed and running to manage models."
  echo "⚠️ 请确保已安装并运行 Ollama。"
fi

# 3. Clone & Build TurboQuant / 下载并编译引擎
mkdir -p "$INSTALL_ROOT"
cd "$INSTALL_ROOT"

if [ ! -d "$PROJECT_NAME" ]; then
  echo "📂 Cloning Repository / 正在克隆仓库..."
  git clone "$REPO_URL" "$PROJECT_NAME"
fi

cd "$PROJECT_NAME"
echo "🔀 Switching to branch / 正在切换到加速分支: $BRANCH"
git checkout "$BRANCH" || git checkout -b "$BRANCH" origin/"$BRANCH"

echo "⚙️ Building with Metal acceleration / 正在编译集成 Metal 加速的版本..."
mkdir -p build && cd build
cmake .. -DGGML_METAL=ON
cmake --build . --config Release -j $(sysctl -n hw.ncpu)

# 4. Pull Models / 下载模型
echo "📥 Downloading AI Logic (Qwen 3.5 27B) / 正在下载模型资源..."
ollama pull kwangsuklee/qwen3.5-27b-claude-4.6-opus-reasoning-distilled:gguf || true
ollama pull nomic-embed-text || true

# 5. Generate One-Click Scripts / 生成自动化启停脚本
echo "📝 Generating one-click scripts / 正在生成自动化脚本..."

cat <<EOF > ~/start_ai_server.sh
#!/bin/bash
LLAMA_SERVER="$INSTALL_ROOT/$PROJECT_NAME/build/bin/llama-server"
# Auto-detecting 16GB+ Blob file for the 27B model
BLOB_PATH=\$(find $MODEL_BLOBS -size +10G | head -n 1)

if [ -z "\$BLOB_PATH" ]; then
  echo "❌ Model blob not found. Run 'ollama pull'."
  exit 1
fi

pkill llama-server || true
echo "🚀 Starting TurboQuant+ Engine (Port 8080, Turbo3 Compression)..."
nohup \$LLAMA_SERVER -m "\$BLOB_PATH" --cache-type-k turbo3 --cache-type-v turbo3 --port 8080 -ngl 99 -c 32768 --host 0.0.0.0 > ~/qwen_27b_server.log 2>&1 &
echo "✅ Server Started. Log: ~/qwen_27b_server.log"
EOF

cat <<EOF > ~/stop_ai_server.sh
#!/bin/bash
echo "🛑 Shutting down AI Server / 正在关闭服务器..."
pkill llama-server && echo "✅ Success / 已关闭" || echo "ℹ️ Not running / 未运行"
EOF

chmod +x ~/start_ai_server.sh ~/stop_ai_server.sh

# 6. Generate macOS .command shortcuts / 生成 macOS 双击启动图标
cat <<EOF > ~/TurboQuant_Start.command
#!/bin/bash
~/start_ai_server.sh
EOF
cat <<EOF > ~/TurboQuant_Stop.command
#!/bin/bash
~/stop_ai_server.sh
EOF
chmod +x ~/TurboQuant_Start.command ~/TurboQuant_Stop.command

# 7. Deployment Complete / 部署完成
echo ""
echo "----------------------------------------------------------------"
echo "✅ Deployment Successful / 部署完成！"
echo "----------------------------------------------------------------"
echo "1. Run: ~/start_ai_server.sh or use Desktop command icon."
echo "2. Update Continue plugin config ($CONFIG_PATH) with project templates."
echo ""
echo "🚀 Happy Local Coding on M3 Max! / 祝您开发愉快！"
