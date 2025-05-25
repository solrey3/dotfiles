#!/usr/bin/env bash
set -euo pipefail

# Check if Docker is already installed
if command -v docker &>/dev/null; then
  echo "✅ Docker is already installed."
else
  echo "🔄 Installing Docker…"

  # 1. Set up Docker’s GPG keyring directory
  sudo mkdir -p /etc/apt/keyrings

  # 2. Download & dearmor the official GPG key
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

  # 3. Add the Docker apt repository
  arch=$(dpkg --print-architecture)
  distro=$(lsb_release -cs)
  echo \
    "deb [arch=${arch} signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/ubuntu ${distro} stable" \
    | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  # 4. Install Docker Engine and related packages
  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

  echo "✅ Docker Engine & CLI installed."
fi

# Optional: add current user to 'docker' group if not already in it
if groups "$USER" | grep -qw docker; then
  echo "ℹ️  User '$USER' is already in the 'docker' group."
else
  echo "➕ Adding user '$USER' to 'docker' group…"
  sudo usermod -aG docker "$USER"
  echo "✅ Added! You'll need to log out and back in (or run 'newgrp docker') for this to take effect."
fi

echo "🎉 Done."