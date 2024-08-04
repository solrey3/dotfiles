#!/bin/bash

# Directory for dotfiles
DOTFILES_DIR="$HOME/dotfiles"

# Clone the repository if it doesn't exist
if [ ! -d "$DOTFILES_DIR" ]; then
  git clone https://github.com/solrey3/dotfiles.git "$DOTFILES_DIR"
else
  echo "Dotfiles directory already exists. Pulling latest changes..."
  cd "$DOTFILES_DIR" && git pull
fi

# Use stow to link dotfiles
cd "$DOTFILES_DIR"
stow -d "$DOTFILES_DIR" -t "$HOME" .

echo "Dotfiles setup complete!"
