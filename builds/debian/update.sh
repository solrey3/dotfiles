#!/bin/bash

# Update starship
echo "Updating starship..."
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes

# Install stow if not already installed
if ! command -v stow &>/dev/null; then
	echo "stow could not be found, installing..."
	sudo apt update
	sudo apt install -y stow
fi

# Define dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"

# Create .stow-local-ignore file to exclude certain files and directories
cat <<EOL >$DOTFILES_DIR/.stow-local-ignore
.git
builds
README.md
LICENSE
EOL

# Use stow to create symlinks for all configurations
stow -d "$DOTFILES_DIR" -t "$HOME" .

# Install Neovim plugins using LazyVim
echo "Installing Neovim plugins..."
nvim --headless -c 'lua require("lazy").sync()' +qa

echo "Update complete."
