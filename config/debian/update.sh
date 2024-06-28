#!/bin/bash

# Clone or update the dotfiles repository
DOTFILES_REPO="https://github.com/solrey3/dotfiles"
DOTFILES_DIR="$HOME/dotfiles"

if [ -d "$DOTFILES_DIR" ]; then
	echo "Updating dotfiles repository..."
	cd "$DOTFILES_DIR" && git pull
else
	echo "Cloning dotfiles repository..."
	git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

# Update starship
echo "Updating starship..."
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes

# Define dotfiles config directory
DOTFILES_CONFIG_DIR="$HOME/dotfiles/config"

# Create the .config directory if it doesn't exist
mkdir -p ~/.config
mkdir -p ~/.config/nvim

# Fix locale issue
sudo locale-gen en_US.UTF-8
sudo bash -c 'echo -e "LANG=en_US.UTF-8\nLC_ALL=en_US.UTF-8" > /etc/default/locale'
source /etc/default/locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Remove bind commands from .bashrc
sed -i '/bind/d' "$DOTFILES_CONFIG_DIR/bash/.bashrc"

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
create_symlink "$DOTFILES_CONFIG_DIR/bash/.bashrc" "$HOME/.bashrc"
create_symlink "$DOTFILES_CONFIG_DIR/bash/.bash_profile" "$HOME/.bash_profile"

# Copy tmux configuration
copy_file "$DOTFILES_CONFIG_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
create_symlink "$DOTFILES_CONFIG_DIR/tmux/tmux_startup.sh" "$HOME/tmux_startup.sh"

# Symlink alacritty configuration
create_symlink "$DOTFILES_CONFIG_DIR/alacritty/alacritty.yml" "$HOME/.config/alacritty.yml"

# Symlink vim configuration
create_symlink "$DOTFILES_CONFIG_DIR/vim/.vimrc" "$HOME/.vimrc"

# Copy all files and directories in nvim directory
copy_file "$DOTFILES_CONFIG_DIR/nvim/" "$HOME/.config/nvim"

# Symlink starship configuration
create_symlink "$DOTFILES_CONFIG_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

# Source the .bashrc to apply changes
source $HOME/.bashrc
