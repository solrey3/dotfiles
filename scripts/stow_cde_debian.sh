#!/bin/bash

# Stow zsh configuration
stow -t ~ zsh

# Stow bash configuration
stow -t ~ bash

# Stow starship configuration
stow -t ~/.config starship

# Stow tmux configuration
stow -t ~ tmux

# Stow vim configuration
stow -t ~ vim

# Stow nvim configuration
stow -t ~/.config/nvim nvim

echo "All files have been stowed to their expected locations."
