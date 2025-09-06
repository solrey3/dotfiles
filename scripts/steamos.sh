#!/usr/bin/env bash
set -euo pipefail

echo "🔄 Setting hostname to india"
sudo hostnamectl set-hostname india
echo "✅ Hostname set to india"

if ! id -u budchris &>/dev/null; then
  echo "🔄 Creating admin user budchris"
  sudo useradd -m -G wheel budchris
  echo "→ Set password for budchris"
  sudo passwd budchris
  echo "✅ User budchris created"
else
  echo "✅ User budchris already exists"
fi

echo "🔄 Resetting Arch keyring"
sudo pacman-key --init
sudo pacman-key --populate
sudo pacman -Syy --noconfirm archlinux-keyring
echo "✅ Arch keyring reset"

echo "🔄 Updating system and installing core packages"
sudo pacman -Syu --noconfirm \
  base-devel tmux starship \
  gcc git gawk jq just openssl tokei lazygit \
  unzip zip p7zip \
  rsync tree stow nnn mc \
  curl wget nmap speedtest-cli \
  ffmpeg yt-dlp \
  figlet fortune-mod cowsay cmatrix \
  networkmanager network-manager-applet proton-vpn-gtk-app nextcloud-client \
  python nodejs npm \
  alacritty github-cli ripgrep fzf zoxide eza fd
echo "✅ Core packages installed"

required_nvim="0.11.4"
echo "🔄 Checking Neovim version"
if command -v nvim &>/dev/null; then
  current_nvim="$(nvim --version | head -n1 | awk '{print $2}')"
else
  current_nvim="0"
fi

if [[ "$(printf '%s\n%s\n' "$required_nvim" "$current_nvim" | sort -V | tail -n1)" != "$current_nvim" ]]; then
  echo "🔄 Installing latest Neovim"
  tmp_dir="$(mktemp -d)"
  curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz -o "$tmp_dir/nvim.tar.gz"
  tar -xzf "$tmp_dir/nvim.tar.gz" -C "$tmp_dir"
  sudo mv "$tmp_dir/nvim-linux-x86_64" /usr/local/
  sudo ln -sf /usr/local/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
  rm -rf "$tmp_dir"
  echo "✅ Neovim installed"
else
  echo "✅ Neovim $current_nvim is up to date"
fi

echo "🔄 Installing yay AUR helper"
if ! command -v yay &>/dev/null; then
  sudo pacman -S --needed --noconfirm base-devel git
  temp_dir="$(mktemp -d)"
  git clone https://aur.archlinux.org/yay.git "$temp_dir/yay"
  (cd "$temp_dir/yay" && makepkg -si --noconfirm)
  rm -rf "$temp_dir"
else
  echo "✅ yay already installed"
fi

echo "🔄 Installing AUR packages"
yay -S --noconfirm \
  wezterm ghostty \
  librewolf-bin google-chrome brave-bin \
  fabric-ai \
  ttf-jetbrains-mono-nerd \
  dysk
echo "✅ AUR packages installed"

echo "🔄 Generating SSH key"
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  mkdir -p "$HOME/.ssh"
  ssh-keygen -t ed25519 -C "solrey3@solrey3.com" -f "$HOME/.ssh/id_ed25519" -N ""
  echo "✅ SSH key generated"
else
  echo "✅ SSH key already exists"
fi

echo "🔄 Configuring git"
git config --global user.email "solrey3@solrey3.com"
git config --global user.name "Solito Reyes III"
echo "✅ Git configured"

echo "🔄 Installing opencode.ai"
curl -fsSL https://opencode.ai/install | bash

echo "🎉 Post-SteamOS setup complete!"
