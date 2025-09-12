#!/usr/bin/env bash
set -euo pipefail

echo "🔄 Updating system and installing core packages"
sudo pacman -Syu --noconfirm \
  base-devel zsh bash tmux starship \
  gcc git gawk jq just openssl tokei lazygit \
  fzf ripgrep \
  unzip zip p7zip \
  rsync tree stow nnn mc zoxide eza fd dysk \
  curl wget nmap speedtest-cli \
  ffmpeg yt-dlp \
  figlet fortune-mod cowsay cmatrix \
  python nodejs npm yarn \
  networkmanager network-manager-applet proton-vpn-gtk-app nextcloud-client \
  alacritty remmina freerdp \
  github-cli \
  btop htop fastfetch lsof

echo "✅ Core packages installed"
