#!/bin/bash

# Update and upgrade system packages
apt update && apt upgrade -y

# Create user and grant sudo privileges
adduser player1
usermod -aG sudo player1
usermod -aG docker player1

# Copy the authorized_keys from root to player1
mkdir -p /home/player1/.ssh
cp /root/.ssh/authorized_keys /home/player1/.ssh/authorized_keys
chown -R player1:player1 /home/player1/.ssh
chmod 700 /home/player1/.ssh
chmod 600 /home/player1/.ssh/authorized_keys

# Install essential packages
apt install -y curl git wget build-essential software-properties-common

# Install unzip and fontconfig for JetBrains Mono Nerd Font
apt install -y unzip fontconfig

# Install rsync
apt install -y rsync

# Install Docker and Docker Compose
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
apt install -y docker-compose

# Install Alacritty, Tmux, and Ripgrep
apt install -y cmake libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
apt install -y alacritty
apt install -y tmux
apt install -y ripgrep

# Install Neovim 0.9 from GitHub releases
curl -LO https://github.com/neovim/neovim/releases/download/v0.9.0/nvim-linux64.tar.gz
tar -xzvf nvim-linux64.tar.gz
mv nvim-linux64 /usr/local/neovim
ln -s /usr/local/neovim/bin/nvim /usr/local/bin/nvim

# Backup existing Neovim configuration
mv /home/player1/.config/nvim{,.bak}
mv /home/player1/.local/share/nvim{,.bak}
mv /home/player1/.local/state/nvim{,.bak}
mv /home/player1/.cache/nvim{,.bak}

# Clone LazyVim starter configuration
git clone https://github.com/LazyVim/starter /home/player1/.config/nvim
rm -rf /home/player1/.config/nvim/.git

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

# Install GitHub CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list >/dev/null
apt update
apt install gh

# Install Google Cloud SDK
echo "deb [signed-by=/usr/share/keyrings/cloud.google-archive-keyring.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google-archive-keyring.gpg
apt update && apt install -y google-cloud-sdk

# Install kubectl
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

# Install 1Password CLI
curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
echo 'deb [signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | tee /etc/apt/sources.list.d/1password.list
apt update && apt install 1password-cli

# Install Miniconda
curl -LO https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p /home/player1/miniconda
echo 'export PATH="/home/player1/miniconda/bin:$PATH"' >>/home/player1/.bashrc

# Install Terraform
curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
apt update && apt install -y terraform

# Install JetBrains Mono Nerd Font
mkdir -p /home/player1/.local/share/fonts
cd /home/player1/.local/share/fonts
curl -fLo "JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
unzip JetBrainsMono.zip
fc-cache -fv

# Ensure locale package is installed
apt install -y locales

# Generate and set locale
locale-gen en_US.UTF-8
echo -e "LANG=en_US.UTF-8\nLC_ALL=en_US.UTF-8" >/etc/default/locale
source /etc/default/locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set correct ownership for player1 home directory
chown -R player1:player1 /home/player1

# Clean up
rm -f get-docker.sh awscliv2.zip Miniconda3-latest-Linux-x86_64.sh JetBrainsMono.zip nvim-linux64.tar.gz

# Source the .bashrc for miniconda to take effect
source /home/player1/.bashrc
