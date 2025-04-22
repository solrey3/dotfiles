#!/bin/bash

# Stow zsh configuration
stow -t ~ zsh

# Stow bash configuration
stow -t ~ bash

# Stow starship configuration
stow -t ~/.config starship

# Stow tmux configuration
stow -t ~ tmux

# Stow vim con
stow -t ~ vim

# Stow nvim configuration
stow -t ~/.config/nvim nvim

# Stow wezterm configuration
stow -t ~ wezterm

# Stow alacritty configuration
stow -t ~/.config/alacritty alacritty

echo "All files have been stowed to their expected locations."
