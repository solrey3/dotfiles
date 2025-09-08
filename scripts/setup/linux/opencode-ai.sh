#!/usr/bin/env bash
set -euo pipefail

# Install Opencode.ai CLI
if command -v opencode &>/dev/null; then
  echo "✅ Opencode.ai CLI is already installed"
  exit 0
fi

echo "🔄 Installing Opencode.ai CLI"
installer_url="https://opencode.ai/install"
echo "→ Running installer from $installer_url"
curl -fsSL "$installer_url" | bash

echo "✅ Opencode.ai installation complete"
