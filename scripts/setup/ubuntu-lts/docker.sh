#!/usr/bin/env bash
set -euo pipefail

# Script: setup-docker-repo-and-engine.sh
# Idempotently configures Docker’s apt repository and installs Docker Engine & CLI.

# Check if Docker is already installed
if command -v docker &>/dev/null; then
  echo "✅ Docker is already installed: $(docker --version)"
else
  echo "🔄 Setting up Docker repository & installing Docker…"

  # Ensure apt prerequisites are present
  echo "→ Installing prerequisites: ca-certificates, curl…"
  sudo apt-get update
  sudo apt-get install -y ca-certificates curl

  # Create keyrings dir if needed
  echo "→ Creating /etc/apt/keyrings…"
  sudo install -m 0755 -d /etc/apt/keyrings

  # Download & install Docker’s official GPG key
  echo "→ Downloading Docker GPG key…"
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add Docker apt repository
  echo "→ Adding Docker apt repository…"
  distro_codename=$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
https://download.docker.com/linux/ubuntu ${distro_codename} stable" \
    | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

  # Update & install Docker packages
  echo "→ Updating apt and installing Docker packages…"
  sudo apt-get update
  sudo apt-get install -y \
    docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  echo "✅ Docker Engine & CLI installation complete."
fi

# Optional: add current user to 'docker' group if desired
if groups "$USER" | grep -qw docker; then
  echo "ℹ️  User '$USER' is already in the 'docker' group."
else
  echo "→ Adding user '$USER' to 'docker' group…"
  sudo usermod -aG docker "$USER"
  echo "✅ Added! Please log out and back in (or run 'newgrp docker') for it to take effect."
fi

echo "🎉 Docker setup complete!"
