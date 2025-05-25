#!/usr/bin/env bash
set -euo pipefail

PKG="brave-browser"

# 1. Check if Brave is already installed
if dpkg -s "$PKG" &>/dev/null; then
  echo "✅ $PKG is already installed."
  exit 0
fi

# 2. Install Brave Browser
echo "🔄 Installing $PKG…"
curl -fsS https://dl.brave.com/install.sh | sudo sh

# 3. Verify installation
if command -v brave-browser &>/dev/null; then
  echo "✅ $PKG installation complete!"
else
  echo "❌ $PKG installation failed."
  exit 1
fi