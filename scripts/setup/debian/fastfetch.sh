#!/usr/bin/env bash
set -euo pipefail

DEB_URL="https://github.com/fastfetch-cli/fastfetch/releases/download/2.44.0/fastfetch-linux-amd64.deb"
DEB_FILE="/tmp/fastfetch.deb"
PKG_NAME="fastfetch"

# 1. Check if fastfetch is already installed
if command -v fastfetch &>/dev/null; then
  echo "✅ fastfetch is already installed: $(fastfetch --version)"
  exit 0
fi

echo "🔄 Installing fastfetch from $DEB_URL…"

# 2. Download the .deb
wget -qO "$DEB_FILE" "$DEB_URL"

# 3. Install via apt to handle dependencies
sudo apt update
sudo apt install -y "$DEB_FILE"

# 4. Cleanup
rm -f "$DEB_FILE"

# 5. Verify
if command -v fastfetch &>/dev/null; then
  echo "✅ fastfetch installation complete: $(fastfetch --version)"
else
  echo "❌ fastfetch installation failed."
  exit 1
fi

