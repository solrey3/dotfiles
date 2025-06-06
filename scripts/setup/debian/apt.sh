#!/usr/bin/env bash
set -euo pipefail

echo "→ Updating apt package index…"
sudo apt update

# Core utilities
echo "→ Installing core utilities…"
sudo apt install -y \
  curl wget unzip zip

# Development tools
echo "→ Installing development tools…"
sudo apt install -y \
  gcc git gh gawk jq fzf just ripgrep tmux

# System monitoring
echo "→ Installing monitoring tools…"
sudo apt install -y \
  htop btop speedtest-cli nmap lsof

# File management & archiving
echo "→ Installing file & archiving tools…"
sudo apt install -y \
  file rsync stow tree p7zip

# Navigation utilities
echo "→ Installing navigation utilities…"
sudo apt install -y \
  mc nnn

# Fun & entertainment
echo "→ Installing fun utilities…"
sudo apt install -y \
  cowsay cmatrix fortune figlet

# Media processing
echo "→ Installing media utilities…"
sudo apt install -y \
  ffmpeg

echo "✅ All packages installed!"
