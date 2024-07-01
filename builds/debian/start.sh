#!/bin/bash

# Function to install starship
install_starship() {
	echo "Updating starship..."
	sudo -u player1 sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes
}

# Function to update Neovim plugins using LazyVim
update_neovim_plugins() {
	echo "Installing Neovim plugins..."
	sudo -u player1 nvim --headless -c 'lua require("lazy").sync()' +qa
}

# Function to set locale
set_locale() {
	echo "Setting locale..."
	apt install -y locales
	locale-gen en_US.UTF-8
	echo -e "LANG=en_US.UTF-8\nLC_ALL=en_US.UTF-8" >/etc/default/locale
	export LANG=en_US.UTF-8
	export LC_ALL=en_US.UTF-8
}

# Update and upgrade system packages
apt update && apt upgrade -y

# Set locale
set_locale

# Check if player1 user exists, if not create user and configure SSH
if id "player1" &>/dev/null; then
	echo "User player1 already exists."
else
	adduser player1
	usermod -aG sudo player1
	usermod -aG docker player1

	# Copy the authorized_keys from root to player1
	mkdir -p /home/player1/.ssh
	cp /root/.ssh/authorized_keys /home/player1/.ssh/authorized_keys
	chown -R player1:player1 /home/player1/.ssh
	chmod 700 /home/player1/.ssh
	chmod 600 /home/player1/.ssh/authorized_keys
fi

# Install essential packages
# Install unzip and fontconfig for JetBrains Mono Nerd Font
apt install -y curl git wget build-essential software-properties-common stow rsync unzip fontconfig

# Check if Docker is installed, if not install Docker and Docker Compose
if ! command -v docker &>/dev/null; then
	curl -fsSL https://get.docker.com -o get-docker.sh
	sh get-docker.sh
	apt install -y docker-compose
	rm -f get-docker.sh
else
	echo "Docker is already installed."
fi

# Check and install JetBrains Mono Nerd Font if not installed
FONT_CHECK=$(sudo -u player1 fc-list | grep -E "JetBrains.*.ttf" | wc -l)
if [ "$FONT_CHECK" -eq 0 ]; then
	echo "JetBrains Mono Nerd Font not found, installing..."
	sudo -u player1 mkdir -p /home/player1/.local/share/fonts
	cd /home/player1/.local/share/fonts
	sudo -u player1 curl -fLo "JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
	sudo -u player1 unzip -o JetBrainsMono.zip
	sudo -u player1 fc-cache -fv
	rm -f JetBrainsMono.zip
else
	echo "JetBrains Mono Nerd Font is already installed."
fi

# Check if Neovim is installed, if not install Neovim, backup config, and clone LazyVim
if ! command -v nvim &>/dev/null; then
	curl -LO https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz
	tar -xzvf nvim-linux64.tar.gz
	mv nvim-linux64 /usr/local/neovim
	ln -s /usr/local/neovim/bin/nvim /usr/local/bin/nvim
	rm -f nvim-linux64.tar.gz

	# Backup existing Neovim configuration
	mv /home/player1/.config/nvim{,.bak}
	mv /home/player1/.local/share/nvim{,.bak}
	mv /home/player1/.local/state/nvim{,.bak}
	mv /home/player1/.cache/nvim{,.bak}

	# Clone LazyVim starter configuration
	git clone https://github.com/LazyVim/starter /home/player1/.config/nvim
	rm -rf /home/player1/.config/nvim/.git

	update_neovim_plugins
else
	echo "Neovim is already installed."
fi

# Check and install AWS CLI if not installed
if ! command -v aws &>/dev/null; then
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	./aws/install
	rm -f awscliv2.zip
else
	echo "AWS CLI is already installed."
fi

# Check and install GitHub CLI if not installed
if ! command -v gh &>/dev/null; then
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
	chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list >/dev/null
	apt update
	apt install gh
else
	echo "GitHub CLI is already installed."
fi

# Check and install Google Cloud SDK if not installed
if ! command -v gcloud &>/dev/null; then
	echo "deb [signed-by=/usr/share/keyrings/cloud.google-archive-keyring.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
	curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google-archive-keyring.gpg
	apt update && apt install -y google-cloud-sdk
else
	echo "Google Cloud SDK is already installed."
fi

# Check and install kubectl if not installed
if ! command -v kubectl &>/dev/null; then
	curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
	chmod +x ./kubectl
	mv ./kubectl /usr/local/bin/kubectl
else
	echo "kubectl is already installed."
fi

# Check and install 1Password CLI if not installed
if ! command -v op &>/dev/null; then
	curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
	echo 'deb [signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | tee /etc/apt/sources.list.d/1password.list
	apt update && apt install 1password-cli
else
	echo "1Password CLI is already installed."
fi

# Check and install Miniconda if not installed
if [ ! -d "/home/player1/miniconda" ]; then
	curl -LO https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
	bash Miniconda3-latest-Linux-x86_64.sh -b -p /home/player1/miniconda
	echo 'export PATH="/home/player1/miniconda/bin:$PATH"' >>/home/player1/.bashrc
	rm -f Miniconda3-latest-Linux-x86_64.sh
else
	echo "Miniconda is already installed."
fi

# Check and install Terraform if not installed
if ! command -v terraform &>/dev/null; then
	curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
	apt update && apt install -y terraform
else
	echo "Terraform is already installed."
fi

# Check and install DigitalOcean CLI (doctl) if not installed
if ! command -v doctl &>/dev/null; then
	curl -sL https://github.com/digitalocean/doctl/releases/download/v1.64.0/doctl-1.64.0-linux-amd64.tar.gz | tar -xzv
	mv doctl /usr/local/bin
else
	echo "DigitalOcean CLI (doctl) is already installed."
fi

# Set correct ownership for player1 home directory
chown -R player1:player1 /home/player1

# Clean up
rm -f get-docker.sh awscliv2.zip Miniconda3-latest-Linux-x86_64.sh JetBrainsMono.zip nvim-linux64.tar.gz

# Source the .bashrc for miniconda to take effect
source /home/player1/.bashrc

# Install starship
install_starship

# Define dotfiles directory
DOTFILES_DIR="/home/player1/dotfiles"

# Function to backup existing files before stowing
backup_existing_files() {
	local target_dir="$1"
	local stow_dir="$2"
	for file in $(stow -n -d "$stow_dir" -t "$target_dir" -v | awk '{print $2}'); do
		if [ -e "$target_dir/$file" ] && [ ! -L "$target_dir/$file" ]; then
			echo "Backing up $target_dir/$file to $target_dir/${file}.bak"
			mv "$target_dir/$file" "$target_dir/${file}.bak"
		fi
	done
}

# Check if dotfiles directory exists, if not clone it
if [ ! -d "$DOTFILES_DIR" ]; then
	echo "dotfiles directory does not exist, cloning..."
	git clone https://github.com/solrey3/dotfiles "$DOTFILES_DIR"
	chown -R player1:player1 "$DOTFILES_DIR"
fi

# Backup existing files before creating symlinks with stow
backup_existing_files "/home/player1" "$DOTFILES_DIR"

# Use stow to create symlinks for all configurations
stow -d "$DOTFILES_DIR" -t "/home/player1" .

# Update Neovim plugins using LazyVim if Neovim was installed
if command -v nvim &>/dev/null; then
	update_neovim_plugins
fi

echo "Setup and update complete."
