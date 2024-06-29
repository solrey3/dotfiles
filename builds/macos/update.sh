#!/bin/bash

# Update starship
echo "Updating starship..."
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes

# Define dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"

# Create the .config directory if it doesn't exist
mkdir -p ~/.config
mkdir -p ~/.config/nvim

# Function to create symbolic links and backup existing regular files
create_symlink() {
	local target=$1
	local link=$2

	if [ -e "$link" ] && [ ! -L "$link" ]; then
		mv "$link" "$link.backup"
		echo "Backed up existing $link to $link.backup"
	fi

	ln -sf "$target" "$link"
	echo "Created symlink: $link -> $target"
}

# Function to copy files and backup existing regular files
copy_file() {
	local target=$1
	local destination=$2

	if [ -e "$destination" ] && [ ! -L "$destination" ]; then
		mv "$destination" "$destination.backup"
		echo "Backed up existing $destination to $destination.backup"
	fi

	rsync -a "$target" "$destination"
	echo "Copied $target to $destination"
}

# Symlink bash configuration
create_symlink "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
create_symlink "$DOTFILES_DIR/.bash_profile" "$HOME/.bash_profile"

# Symlink zsh configuration
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# Copy tmux configuration
create_symlink "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
create_symlink "$DOTFILES_DIR/tmux_startup.sh" "$HOME/tmux_startup.sh"

# Symlink alacritty configuration
create_symlink "$DOTFILES_DIR/.config/alacritty.yml" "$HOME/.config/alacritty.yml"

# Symlink vim configuration
create_symlink "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"

# Copy all files and directories in nvim directory
copy_file "$DOTFILES_DIR/.config/nvim/" "$HOME/.config/nvim"

# Symlink starship configuration
create_symlink "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

# Install Neovim plugins using LazyVim
echo "Installing Neovim plugins..."
nvim --headless "+Lazy sync" +qa

echo "Update complete."
