#!/bin/bash

# Stow alacritty configuration
stow -t ~/.config/alacritty alacritty

# Stow bash configuration
stow -t ~ bash

# Stow nix configuration
stow -t ~/.config/nix nix

# Stow nvim configuration
stow -t ~/.config/nvim nvim

# Stow starship configuration
stow -t ~/.config starship

# Stow tmux configuration
stow -t ~ tmux

# Stow vim configuration
stow -t ~ vim

# Stow zsh configuration
stow -t ~ zsh

echo "All files have been stowed to their expected locations."