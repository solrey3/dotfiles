#!/usr/bin/env bash
set -euo pipefail

# Script: setup-docker-debian.sh
# Idempotently configures Docker’s apt repository on Debian and installs Docker Engine & CLI.

# 1. Check if Docker is already installed
if command -v docker &>/dev/null; then
  echo "✅ Docker is already installed: $(docker --version)"
  exit 0
fi

echo "🔄 Setting up Docker repository & installing Docker on Debian…"

# 2. Install prerequisites
echo "→ Installing prerequisites: ca-certificates, curl…"
sudo apt-get update
sudo apt-get install -y ca-certificates curl

# 3. Create keyrings dir if needed
echo "→ Creating /etc/apt/keyrings…"
sudo install -m 0755 -d /etc/apt/keyrings

# 4. Download & install Docker’s official GPG key
echo "→ Downloading Docker GPG key…"
sudo curl -fsSL https://download.docker.com/linux/debian/gpg \
  -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# 5. Add Docker apt repository
echo "→ Adding Docker apt repository…"
CODENAME=$(. /etc/os-release && echo "$VERSION_CODENAME")
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
https://download.docker.com/linux/debian ${CODENAME} stable" |
  sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

# 6. Update & install Docker packages
echo "→ Updating apt and installing Docker packages…"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "✅ Docker Engine & CLI installation complete."

# 7. (Optional) Add current user to 'docker' group
if groups "$USER" | grep -qw docker; then
  echo "ℹ️  User '$USER' is already in the 'docker' group."
else
  echo "→ Adding user '$USER' to 'docker' group…"
  sudo usermod -aG docker "$USER"
  echo "✅ Added! Log out and back in (or run 'newgrp docker') for it to take effect."
fi

echo "🎉 Docker setup on Debian complete!"

