#!/bin/bash

# Define the repo location
REPO_DIR="$HOME/dotfiles"

# Function to create symlinks
create_symlink() {
	local src="$1"
	local dest="$2"

	if [ -L "$dest" ]; then
		echo "Removing existing symlink $dest"
		rm "$dest"
	elif [ -e "$dest" ]; then
		echo "Backing up existing file $dest to ${dest}.bak"
		mv "$dest" "${dest}.bak"
	fi

	echo "Creating symlink from $src to $dest"
	ln -sf "$src" "$dest"
}

# Update Bash configuration
create_symlink "$REPO_DIR/bash/.bashrc" "$HOME/.bashrc"
create_symlink "$REPO_DIR/bash/.bash_profile" "$HOME/.bash_profile"

# Update Tmux configuration
create_symlink "$REPO_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Update Neovim configuration
mkdir -p "$HOME/.config/nvim"
create_symlink "$REPO_DIR/nvim/init.lua" "$HOME/.config/nvim/init.lua"
mkdir -p "$HOME/.config/nvim/lua/config"
create_symlink "$REPO_DIR/nvim/lua/config/keymaps.lua" "$HOME/.config/nvim/lua/config/keymaps.lua"
create_symlink "$REPO_DIR/nvim/lua/config/options.lua" "$HOME/.config/nvim/lua/config/optons.lus"
mkdir -p "$HOME/.config/nvim/lua/plugins"
create_symlink "$REPO_DIR/nvim/lua/plugins/neo-tree.lua" "$HOME/.config/nvim/lua/plugins/neo-tree.lua"
create_symlink "$REPO_DIR/nvim/lua/plugins/telescope.lua" "$HOME/.config/nvim/lua/plugins/telescope.lua"
create_symlink "$REPO_DIR/vim/.vimrc" "$HOME/.vimrc"

# Update Alacritty configuration
mkdir -p "$HOME/.config/alacritty"
create_symlink "$REPO_DIR/alacritty/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"

# Update VNC configuration
mkdir -p "$HOME/.vnc"
create_symlink "$REPO_DIR/vnc/xstartup" "$HOME/.vnc/xstartup"

# Reload Bash
echo "Reloading bash"
exec bash
