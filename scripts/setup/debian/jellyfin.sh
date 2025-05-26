#!/usr/bin/env bash
set -euo pipefail

# Script: setup-jellyfin-debian.sh
# Installs Jellyfin on Debian via the official install script.

# 1. Check if Jellyfin is already installed
if dpkg -s jellyfin &>/dev/null; then
  echo "✅ Jellyfin is already installed."
  exit 0
fi

# 2. Run the upstream Debian installer
echo "🔄 Installing Jellyfin…"
curl -fsSL https://repo.jellyfin.org/install-debuntu.sh | sudo bash

# 3. Verify installation
if dpkg -s jellyfin &>/dev/null; then
  echo "✅ Jellyfin installation complete."
else
  echo "❌ Jellyfin failed to install."
  exit 1
fi
