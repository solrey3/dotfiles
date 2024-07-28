#!/bin/bash

## Upgrade/Upgrade
sudo apt update && sudo apt upgrade -y

## Setup NVIDIA drivers

## Install Proton VPN
wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3-3_all.deb
sudo dpkg -i ./protonvpn-stable-release_1.0.3-3_all.deb && sudo apt update
sudo apt install proton-vpn-gnome-desktop

# Install essential packages
# Install unzip and fontconfig for JetBrains Mono Nerd Font
sudo apt install -y curl git wget build-essential software-properties-common stow rsync unzip fontconfig ripgrep gh alacritty tmux

# Check if Docker is installed, if not install Docker and Docker Compose
if ! command -v docker &>/dev/null; then
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo apt install -y docker-compose
  rm -f get-docker.sh
else
  echo "Docker is already installed."
fi

# Check and install JetBrains Mono Nerd Font if not installed
FONT_CHECK=$(sudo -u player1 fc-list | grep -E "JetBrains.*.ttf" | wc -l)
if [ "$FONT_CHECK" -eq 0 ]; then
  echo "JetBrains Mono Nerd Font not found, installing..."
  sudo -u player1 mkdir -p /home/player1/.local/share/fonts
  cd /home/player1/.local/share/fonts
  sudo -u player1 curl -fLo "JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
  sudo -u player1 unzip -o JetBrainsMono.zip
  sudo -u player1 fc-cache -fv
  rm -f JetBrainsMono.zip
else
  echo "JetBrains Mono Nerd Font is already installed."
fi

# Function to update Neovim plugins using LazyVim
update_neovim_plugins() {
  echo "Installing Neovim plugins..."
  nvim --headless -c 'lua require("lazy").sync()' +qa
}

# Check if Neovim is installed, if not install Neovim, backup config, and clone LazyVim
if ! command -v nvim &>/dev/null; then
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
  sudo rm -rf /opt/nvim
  sudo tar -C /opt -xzf nvim-linux64.tar.gz   
  rm -f nvim-linux64.tar.gz

  # Backup existing Neovim configuration
  #mv /home/player1/.config/nvim{,.bak}
  #mv /home/player1/.local/share/nvim{,.bak}
  #mv /home/player1/.local/state/nvim{,.bak}
  #mv /home/player1/.cache/nvim{,.bak}

  # Clone LazyVim starter configuration
  #git clone https://github.com/LazyVim/starter /home/player1/.config/nvim
  #rm -rf /home/player1/.config/nvim/.git

  update_neovim_plugins
else
  echo "Neovim is already installed."
fi

# Clean up
rm -f get-docker.sh JetBrainsMono.zip nvim-linux64.tar.gz protonvpn-stable-release_1.0.3-3_all.deb

# Define dotfiles directory
DOTFILES_DIR="/home/player1/dotfiles"

# Function to backup existing files before stowing
backup_existing_files() {
  local target_dir="$1"
  local stow_dir="$2"
  for file in $(stow -n -d "$stow_dir" -t "$target_dir" -v | awk '{print $2}'); do
    if [ -e "$target_dir/$file" ] && [ ! -L "$target_dir/$file" ]; then
      echo "Backing up $target_dir/$file to $target_dir/${file}.bak"
      mv "$target_dir/$file" "$target_dir/${file}.bak"
    fi
  done
}

# Check if dotfiles directory exists, if not clone it
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "dotfiles directory does not exist, cloning..."
  git clone https://github.com/solrey3/dotfiles "$DOTFILES_DIR"
  chown -R player1:player1 "$DOTFILES_DIR"
fi

# Backup existing files before creating symlinks with stow
backup_existing_files "/home/player1" "$DOTFILES_DIR"

# Use stow to create symlinks for all configurations
stow -d "$DOTFILES_DIR" -t "/home/player1" .

# Update Neovim plugins using LazyVim if Neovim was installed
if command -v nvim &>/dev/null; then
  update_neovim_plugins
fi

echo "Setup and update complete."
