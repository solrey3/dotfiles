#!/usr/bin/env bash
set -euo pipefail

# Fresh Post-Omarchy desktop setup

# 1. Update system and install core packages
sudo pacman -Syu \
  tmux \
  gcc git gawk jq just openssl tokei lazygit \
  unzip zip p7zip \
  rsync tree stow nnn mc \
  curl wget nmap speedtest-cli \
  ffmpeg yt-dlp \
  figlet fortune-mod cowsay cmatrix \
  networkmanager network-manager-applet proton-vpn-gtk-app nextcloud-client

# 2. Install yay AUR helper if missing
if ! command -v yay &>/dev/null; then
  sudo pacman -S --needed base-devel git
  tempdir=$(mktemp -d)
  git clone https://aur.archlinux.org/yay.git "$tempdir/yay"
  (cd "$tempdir/yay" && makepkg -si --noconfirm)
  rm -rf "$tempdir"
else
  echo "✅ yay already installed"
fi

# 3. Install additional packages via yay
yay -S \
  wezterm ghostty \
  librewolf-bin google-chrome \
  fabric-ai

# 6. Install Brave Browser
curl -fsS https://dl.brave.com/install.sh | sh

# 7. Install opencode.ai
curl -fsSL https://opencode.ai/install | bash

echo "🎉 Post-Omarchy setup complete!"
