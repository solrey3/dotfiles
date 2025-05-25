#!/usr/bin/env bash
set -euo pipefail

# Check if Jellyfin is already installed
if dpkg -s jellyfin &>/dev/null; then
  echo "✅ jellyfin is already installed."
else
  echo "🔄 Installing Jellyfin…"

  # 1. Import the GPG key
  echo "→ Importing Jellyfin GPG key…"
  wget -qO - https://repo.jellyfin.org/ubuntu/jellyfin_team.gpg.key \
    | sudo apt-key add - >/dev/null

  # 2. Add the Jellyfin apt repository
  echo "→ Adding Jellyfin repository…"
  arch=$(dpkg --print-architecture)
  distro=$(lsb_release -cs)
  repo="deb [arch=${arch}] https://repo.jellyfin.org/ubuntu ${distro} main"
  echo "${repo}" | sudo tee /etc/apt/sources.list.d/jellyfin.list >/dev/null

  # 3. Update & install
  sudo apt update
  sudo apt install -y jellyfin

  echo "✅ Jellyfin installed."
fi

# 4. Enable and start the Jellyfin service
echo "→ Enabling and starting jellyfin service…"
sudo systemctl enable --now jellyfin

echo "🎉 Done."