#!/usr/bin/env bash
set -euo pipefail

# Fresh CachyOS COSMIC desktop setup

# 1. Update system and install core packages
sudo pacman -Syu \
  zsh bash starship tmux \
  gcc git gawk jq just openssl tokei lazygit \
  btop htop fastfetch lsof \
  file unzip zip p7zip \
  rsync tree stow nnn mc \
  curl wget nmap speedtest-cli \
  ffmpeg yt-dlp \
  fzf ripgrep \
  figlet fortune-mod cowsay cmatrix \
  kubectl k9s helm terraform \
  nodejs yarn \
  github-cli bitwarden-cli \
  neovim \
  proton-vpn-gtk-app

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
  bitwarden 1password-cli fabric-ai

# 4. Install JetBrains Mono Nerd Font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip JetBrainsMono.zip
fc-cache -fv

# 5. Install LazyVim starter
if [ ! -d ~/.config/nvim ]; then
  git clone https://github.com/LazyVim/starter ~/.config/nvim
else
  echo "⚠️  ~/.config/nvim already exists, skipping clone"
fi
rm -rf ~/.config/nvim/.git

# 6. Install Brave Browser
curl -fsS https://dl.brave.com/install.sh | sh

# 7. Install opencode.ai
curl -fsSL https://opencode.ai/install | bash

# 8. Set default shell to Zsh
chsh -s "$(command -v zsh)"

echo "🎉 CachyOS setup complete!"
