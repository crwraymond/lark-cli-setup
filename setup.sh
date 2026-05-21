#!/bin/bash
set -e

echo "🚀 Lark CLI Setup"
echo "================="

# Check Node.js
if ! command -v node &> /dev/null; then
  echo "❌ Node.js not found. Please install Node.js >= 16 from https://nodejs.org"
  exit 1
fi

NODE_VERSION=$(node -e "process.exit(parseInt(process.versions.node.split('.')[0]) < 16 ? 1 : 0)" 2>&1 && echo "ok" || echo "old")
if [ "$NODE_VERSION" = "old" ]; then
  echo "❌ Node.js version too old. Please upgrade to >= 16"
  exit 1
fi

echo "✅ Node.js $(node --version)"

# Install lark-cli
echo ""
echo "📦 Installing lark-cli..."
npm install -g lark-cli
echo "✅ lark-cli $(lark-cli --version) installed"

# Install skills
echo ""
echo "🧠 Installing AI skills..."
npx skills install lark-cli -g
echo "✅ Skills installed"

# Run config init
echo ""
echo "⚙️  Configuring lark-cli..."
echo "You will need your App ID (cli_xxx) and App Secret from the Lark Developer Console."
echo "👉 https://open.larksuite.com/app"
echo ""
lark-cli config init

# Verify
echo ""
echo "🔍 Verifying setup..."
lark-cli im +chat-list --as bot > /dev/null 2>&1 && echo "✅ Bot identity working" || echo "⚠️  Bot identity check failed — check your App ID and Secret"

echo ""
echo "🎉 Setup complete! Run 'lark-cli --help' to get started."
echo "📖 Full docs: https://github.com/crwraymond/lark-cli-setup"
