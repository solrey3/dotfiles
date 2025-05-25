#!/usr/bin/env bash
set -euo pipefail

# Check if Ollama is already installed
if command -v ollama &>/dev/null; then
  echo "✅ Ollama is already installed."
else
  echo "🔄 Installing Ollama…"

  # Download & run Ollama’s installer script
  curl -fsSL https://ollama.com/install.sh | sh

  echo "✅ Ollama installation complete."
fi

echo "🎉 Done."