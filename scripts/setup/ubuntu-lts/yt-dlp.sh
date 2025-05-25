#!/usr/bin/env bash
set -euo pipefail

# Script: setup-yt-dlp.sh
# Installs yt-dlp via the tomtomtom PPA if not already present.

# 1. Check if yt-dlp is already installed
if command -v yt-dlp &>/dev/null; then
  echo "✅ yt-dlp is already installed: $(yt-dlp --version)"
  exit 0
else
  echo "🔄 Installing yt-dlp…"
fi

# 2. Add the PPA repository if it's not already present
if ! grep -R "tomtomtom/yt-dlp" /etc/apt/sources.list.d >/dev/null 2>&1; then
  echo "→ Adding the tomtomtom/yt-dlp PPA…"
  sudo add-apt-repository -y ppa:tomtomtom/yt-dlp
else
  echo "ℹ️  tomtomtom/yt-dlp PPA already exists."
fi

# 3. Update and install yt-dlp
echo "→ Updating package lists…"
sudo apt update
echo "→ Installing yt-dlp…"
sudo apt install -y yt-dlp

# 4. Verify installation
if command -v yt-dlp &>/dev/null; then
  echo "✅ yt-dlp installation complete: $(yt-dlp --version)"
else
  echo "❌ yt-dlp failed to install."
  exit 1
fi