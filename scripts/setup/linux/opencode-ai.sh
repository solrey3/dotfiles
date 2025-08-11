#!/usr/bin/env bash
set -euo pipefail

# Install Opencode.ai CLI
if command -v opencode &>/dev/null; then
  echo "✅ Opencode.ai CLI is already installed."
  exit 0
fi

echo "🔄 Installing Opencode.ai CLI…"
curl -fsSL https://opencode.ai/install | bash

echo "✅ Opencode.ai installation complete."
