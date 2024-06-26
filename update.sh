#!/bin/bash

# Update starship
echo "Updating starship..."
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes

# Define dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"

# Create the .config directory if it doesn't exist
mkdir -p ~/.config

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

	cp "$target" "$destination"
	echo "Copied $target to $destination"
}

# Symlink bash configuration
create_symlink "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"
create_symlink "$DOTFILES_DIR/bash/.bash_profile" "$HOME/.bash_profile"

# Symlink zsh configuration
create_symlink "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

# Copy tmux configuration
copy_file "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
create_symlink "$DOTFILES_DIR/tmux/tmux_startup.sh" "$HOME/tmux_startup.sh"

# Symlink alacritty configuration
create_symlink "$DOTFILES_DIR/alacritty/alacritty.yml" "$HOME/.config/alacritty.yml"

# Symlink vim configuration
create_symlink "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"

# Symlink nvim configuration
create_symlink "$DOTFILES_DIR/nvim/init.lua" "$HOME/.config/nvim/init.lua"

# Symlink starship configuration
create_symlink "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

# Install Neovim plugins
echo "Installing Neovim plugins..."
nvim --headless "+Lazy! sync" +qa

echo "Update complete."
