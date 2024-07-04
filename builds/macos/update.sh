#!/bin/bash

# Function to check if a command exists and install it using brew if it doesn't
check_and_install() {
  if ! command -v $1 &>/dev/null; then
    echo "$1 could not be found, installing..."
    brew install $1
  else
    echo "$1 is already installed."
  fi
}

# Function to check if a Homebrew package is installed and install it if it isn't
check_brew_install() {
  if ! brew list $1 &>/dev/null; then
    echo "$1 is not installed via Homebrew, installing..."
    brew install $1
  else
    echo "$1 is already installed via Homebrew."
  fi
}

# Function to install Docker and Docker Compose
install_docker() {
  if ! command -v docker &>/dev/null; then
    echo "Docker could not be found, installing..."
    brew install --cask docker
    echo "Please start Docker from the Applications folder and allow it to complete installation."
  else
    echo "Docker is already installed."
  fi

  if ! command -v docker-compose &>/dev/null; then
    echo "Docker Compose could not be found, installing..."
    brew install docker-compose
  else
    echo "Docker Compose is already installed."
  fi
}

# Check for Homebrew and install if not found
if ! command -v brew &>/dev/null; then
  echo "Homebrew could not be found, installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed."
fi

# Update Homebrew and upgrade installed packages
echo "Updating Homebrew..."
brew update

echo "Upgrading installed packages..."
brew upgrade

# Check and install necessary tools
check_and_install bash
check_and_install git
check_and_install stow
check_and_install tmux
check_and_install alacritty
check_brew_install ripgrep
check_brew_install neovim
check_brew_install bitwarden-cli

# Install Docker and Docker Compose
install_docker

# Define dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"

# Clone the dotfiles repository if it does not exist
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles repository..."
  git clone https://github.com/solrey3/dotfiles "$DOTFILES_DIR"
fi

# Update starship
echo "Updating starship..."
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes

# Use stow to create symlinks for all configurations
stow -d "$DOTFILES_DIR" -t "$HOME" .

# Install Neovim plugins using LazyVim
echo "Installing Neovim plugins..."
nvim --headless -c 'lua require("lazy").sync()' +qa

echo "Update complete."
