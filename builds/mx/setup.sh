#!/bin/bash

## Step 1: Run `sudo apt update && sudo apt upgrade -y` manually
#
## Step 2: Install NVIDIA drivers if necessary
#
## Step 3: The Script
cd

## Upgrade/Upgrade
sudo apt update && sudo apt upgrade -y

## Install Proton VPN
if sudo dpkg -s proton-vpn-gnome-desktop; then
  echo "VPN already set."
else
  wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3-3_all.deb
  sudo dpkg -i ./protonvpn-stable-release_1.0.3-3_all.deb && sudo apt update
  sudo apt install proton-vpn-gnome-desktop -y
  rm protonvpn-stable-release_1.0.3-3_all.deb
fi

## Install essential packages
### Install unzip and fontconfig for JetBrains Mono Nerd Font
sudo apt install -y \
  alacritty \
  apt-transport-https \
  build-essential \
  ca-certificates \
  curl \
  fontconfig \
  git \
  gh \
  gnupg \
  nodejs \
  npm \
  remmina \
  remmina-plugin-rdp \
  ripgrep \
  rsync \
  software-properties-common \
  stow \
  tmux \
  unzip \
  wget

## Setup NeoVim
### Check and install JetBrains Mono Nerd Font if not installed
FONT_CHECK=$(sudo -u player1 fc-list | grep -E "JetBrains.*.ttf" | wc -l)
if [ "$FONT_CHECK" -eq 0 ]; then
  echo "JetBrains Mono Nerd Font not found, installing..."
  mkdir -p /home/player1/.local/share/fonts
  cd /home/player1/.local/share/fonts
  curl -fLo "JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
  unzip -o JetBrainsMono.zip
  sudo -u player1 fc-cache -fv
  rm -f JetBrainsMono.zip
else
  echo "JetBrains Mono Nerd Font is already installed."
fi

### Check if Neovim is installed, if not install Neovim, backup config, and clone LazyVim
if ! command -v nvim &>/dev/null; then
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
  sudo rm -rf /opt/nvim
  sudo tar -C /opt -xzf nvim-linux64.tar.gz
  rm -f nvim-linux64.tar.gz
else
  echo "Neovim is already installed."
fi

# Function to install starship
install_starship() {
  echo "Updating starship..."
  sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes
}
install_starship

## Setup dotfiles
### Define dotfiles directory
DOTFILES_DIR="/home/player1/dotfiles"

### Function to backup existing files before stowing
backup_existing_files() {
  local target_dir="$1"
  local stow_dir="$2"
  # List all files that stow would manage
  stow -n -d "$stow_dir" -t "$target_dir" -v | while read -r action file; do
    target_file="$target_dir/$file"
    # Check if target is a regular file
    if [ -f "$target_file" ] && [ ! -L "$target_file" ]; then
      echo "Backing up $target_file to ${target_file}.bak"
      mv "$target_file" "${target_file}.bak"
    fi
  done
}

### Check if dotfiles directory exists, if not clone it
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "dotfiles directory does not exist, cloning..."
  git clone https://github.com/solrey3/dotfiles "$DOTFILES_DIR"
fi

### Backup existing files before creating symlinks with stow
backup_existing_files "/home/player1" "$DOTFILES_DIR"

if [ -f ~/.bashrc ]; then
  mv ~/.bashrc ~/.bashrc.bak
fi

### Use stow to create symlinks for all configurations
stow -d "$DOTFILES_DIR" -t "/home/player1" .

source ~/.bashrc

### Function to update Neovim plugins using LazyVim
update_neovim_plugins() {
  echo "Installing Neovim plugins..."
  nvim --headless -c 'lua require("lazy").sync()' +qa
}
### Update Neovim plugins using LazyVim if Neovim was installed
if command -v nvim &>/dev/null; then
  update_neovim_plugins
fi

## Setup Dev Tools
### Check if Docker is installed, if not install Docker and Docker Compose
if ! command -v docker &>/dev/null; then
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo apt install -y docker-compose
  rm -f get-docker.sh
else
  echo "Docker is already installed."
fi

### kubectl
if ! command -v kubectl &>/dev/null; then
  # If the folder `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
  sudo mkdir -p -m 755 /etc/apt/keyrings
  curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
  sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg # allow unprivileged APT programs to read this keyring
  # This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
  echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
  sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list # helps tools such as command-not-found to work correctly
  sudo apt-get update
  sudo apt-get install -y kubectl
else
  echo "kubectl is already installed."
fi

### terraform
if ! command -v terraform &>/dev/null; then
  wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
  sudo apt update && sudo apt install -y terraform
else
  echo "Dude! Terraform is already installed."
fi

### yarn
sudo npm install --global yarn
echo "Cat got its yarn."

### Typescript Tools
##### cdktf, cdk8s
yarn global add ink@^3.0.0 react@^17.0.2
yarn global add cdk8s-cli cdktf-cli
##### playwright
yarn add -D playwright

### Python Tools
#### Miniconda
if conda -V; then
  echo "Miniconda installed, BRO."
else
  MINICONDA_INSTALLER=Miniconda3-latest-Linux-x86_64.sh
  wget https://repo.anaconda.com/miniconda/$MINICONDA_INSTALLER
  bash $MINICONDA_INSTALLER -b
  export PATH=~/miniconda3/bin:$PATH
  rm Miniconda3-latest-Linux-x86_64.sh
fi
##### Conda Environment with Jupyter Notebook, Pandas, matplotlib, Flask, and BeautifulSoup
ENV_NAME="ds"
##### Function to check if conda environment exists
conda_env_exists() {
  conda info --envs | grep -w $1 &>/dev/null
  return $?
}
##### Check if conda env exists
if conda_env_exists $ENV_NAME; then
  echo "Conda environment '$ENV_NAME' already exists."
else
  echo "Creating conda env '$ENV_NAME' in Python 3.9."
  conda create -n $ENV_NAME python=3.9 -y
  conda activate $ENV_NAME
  conda install -n $ENV_NAME jupyter pandas matplotlib sqlalchemy sqlite psycopg2 pymongo beuatifulsoup4 lxml selenium splinter flask flask-pymongo -y
  echo "Conda environment '$ENV_NAME' created successfully."
fi

## Plats
### gcloud
if ! command -v gcloud &>/dev/null; then
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
  sudo apt-get update && sudo apt-get install -y \
    google-cloud-cli \
    google-cloud-cli-config-connector \
    google-cloud-cli-gke-gcloud-auth-plugin \
    google-cloud-cli-terraform-validator
else
  echo "gcloud is already on 9."
fi

### azure
if ! command -v az &>/dev/null; then
  curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
else
  echo "Azure is all about it."
fi

### aws
#### Check and install AWS CLI if not installed
if ! command -v aws &>/dev/null; then
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  rm -f awscliv2.zip
else
  echo "AWS CLI is already installed."
fi

### doctl
#### Check and install DigitalOcean CLI (doctl) if not installed
if ! command -v doctl &>/dev/null; then
  curl -sL https://github.com/digitalocean/doctl/releases/download/v1.64.0/doctl-1.64.0-linux-amd64.tar.gz | tar -xzv
  sudo mv doctl /usr/local/bin
else
  echo "DigitalOcean CLI (doctl) is already installed."
fi

## Other Stuff
### 1Password
# Check and install 1Password CLI if not installed
if ! command -v op &>/dev/null; then
  curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
  echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
  sudo apt update && sudo apt install -y 1password-cli
else
  echo "1Password CLI is already installed."
fi

### Brave Browser
if brave-browser --version; then
  echo "Yo, you already Brave."
else
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt update
  sudo apt install -y brave-browser
fi

#### Chrome extensions for Brave
##### DuckDuckGo Essentials
##### Privacy Badger
##### Bitwarden
##### Vimium
##### Clear Cache
##### JSON Formatter

### Nextcloud
### Obsidian

## Clean up
rm -f get-docker.sh JetBrainsMono.zip nvim-linux64.tar.gz protonvpn-stable-release_1.0.3-3_all.deb
sudo apt autoremove -y
sudo apt clean

## ALL DONE!!!
echo "Setup and update complete."
