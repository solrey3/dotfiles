#!/usr/bin/env bash
set -euo pipefail

# Directory where dotfiles repo should live
dotfiles_dir="$HOME/.dotfiles"

# 1. Clone dotfiles repo if it doesn't exist
if [ ! -d "$dotfiles_dir" ]; then
  echo "→ Cloning dotfiles into $dotfiles_dir..."
  git clone https://github.com/solrey3/dotfiles.git "$dotfiles_dir"
fi

# 2. Enter the dotfiles directory
echo "→ Entering $dotfiles_dir"
cd "$dotfiles_dir"

# 3. Stow configurations
echo "→ Stowing configurations..."

# Zsh
stow -t ~ zsh

# Bash
stow -t ~ bash

# Starship
stow -t ~/.config starship

# Tmux
stow -t ~ tmux

# Vim
stow -t ~ vim

# Neovim
stow -t ~/.config/nvim nvim

# WezTerm
stow -t ~ wezterm

# Alacritty
stow -t ~/.config/alacritty alacritty

# i3
stow ~/.config/i3 i3

echo "✅ All files have been stowed to their expected locations."

