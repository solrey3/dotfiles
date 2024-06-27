#!/bin/bash

# Update and upgrade system packages
sudo apt update && sudo apt upgrade -y

# Update starship
echo "Updating starship..."
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes

# Define dotfiles directory
DOTFILES_DIR="$HOME/dotfiles/config"

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

# Switch to player1 user to clone and apply dotfiles
sudo -u player1 bash <<EOF

# Clone dotfiles repository
if [ ! -d "\$HOME/dotfiles" ]; then
    git clone https://github.com/solrey3/dotfiles.git \$HOME/dotfiles
else
    cd \$HOME/dotfiles
    git pull origin main
fi

# Symlink bash configuration
create_symlink "\$DOTFILES_DIR/bash/.bashrc" "\$HOME/.bashrc"
create_symlink "\$DOTFILES_DIR/bash/.bash_profile" "\$HOME/.bash_profile"

# Copy tmux configuration
copy_file "\$DOTFILES_DIR/tmux/.tmux.conf" "\$HOME/.tmux.conf"
create_symlink "\$DOTFILES_DIR/tmux/tmux_startup.sh" "\$HOME/tmux_startup.sh"

# Symlink alacritty configuration
create_symlink "\$DOTFILES_DIR/alacritty/alacritty.yml" "\$HOME/.config/alacritty.yml"

# Symlink vim configuration
create_symlink "\$DOTFILES_DIR/vim/.vimrc" "\$HOME/.vimrc"

# Copy all files and directories in nvim directory
copy_file "\$DOTFILES_DIR/nvim/" "\$HOME/.config/nvim"

# Symlink starship configuration
create_symlink "\$DOTFILES_DIR/starship/starship.toml" "\$HOME/.config/starship.toml"

EOF

# Source the .bashrc to apply changes
source /home/player1/.bashrc
