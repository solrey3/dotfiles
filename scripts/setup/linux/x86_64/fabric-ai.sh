#!/usr/bin/env bash
set -euo pipefail

# Check if Fabric AI CLI is already installed
if command -v fabric &>/dev/null; then
  echo "✅ Fabric AI CLI is already installed."
  exit 0
fi

echo "🔄 Installing Fabric AI CLI…"

# Temporary download location
TMP_BIN="$HOME/fabric"

# 1. Download the latest Fabric AI binary
curl -fsSL "https://github.com/danielmiessler/fabric/releases/latest/download/fabric-linux-amd64" \
  -o "$TMP_BIN"

# 2. Make it executable
chmod +x "$TMP_BIN"

# 3. Move into place
sudo mv "$TMP_BIN" /usr/local/bin/fabric

echo "✅ Fabric AI CLI installation complete."
