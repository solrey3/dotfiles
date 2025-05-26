#!/usr/bin/env bash
set -euo pipefail

DEB_URL="https://github.com/mkasberg/ghostty-ubuntu/releases/download/1.1.3-0-ppa2/ghostty_1.1.3-0.ppa2_amd64_24.04.deb"
DEB_FILE="ghostty.deb"
PKG="ghostty"

# 1. Check if ghostty is already installed
if command -v ghostty &>/dev/null; then
  echo "✅ ghostty is already installed: $(ghostty --version 2>&1)"
  exit 0
fi

echo "🔄 Installing ghostty…"

# 2. Download the .deb
wget -qO "$DEB_FILE" "$DEB_URL"

# 3. Install the package
sudo dpkg -i "$DEB_FILE" || true

# 4. Fix any missing dependencies
sudo apt update
sudo apt install -f -y

# 5. Cleanup
rm -f "$DEB_FILE"

# 6. Verify installation
if command -v ghostty &>/dev/null; then
  echo "✅ ghostty installation complete: $(ghostty --version 2>&1)"
else
  echo "❌ ghostty failed to install."
  exit 1
fi