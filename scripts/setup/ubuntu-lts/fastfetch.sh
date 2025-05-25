#!/usr/bin/env bash
set -euo pipefail

DEB_URL="https://github.com/fastfetch/releases/download/2.36.1/fastfetch-linux-amd64.deb"
DEB_FILE="fastfetch.deb"

# 1. Check if fastfetch is already installed
if command -v fastfetch &>/dev/null; then
  echo "✅ fastfetch is already installed."
  exit 0
fi

echo "🔄 Installing fastfetch…"

# 2. Download the .deb
wget -qO "$DEB_FILE" "$DEB_URL"

# 3. Install the package
sudo dpkg -i "$DEB_FILE"

# 4. Fix any missing dependencies
sudo apt update
sudo apt install -f -y

# 5. Cleanup
rm -f "$DEB_FILE"

# 6. Verify
if command -v fastfetch &>/dev/null; then
  echo "✅ fastfetch installation complete."
else
  echo "❌ fastfetch failed to install."
  exit 1
fi