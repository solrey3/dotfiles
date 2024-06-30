# dotfiles

Config files galore! for bash environments.

## About this Repo

This repo contains dotfiles for a bash shell environment on macos and debian. There is also a `builds` folder that contains setup/update scripts, docker and terraform files for services I use. 

I chose bash over zsh on macOS because, as a DevOps engineer, the systems I am responsible for are mostly Linux-based, which will (more times that not) have a bash shell. AAAAAAAND, beacuse I have an M2 chipped Mac that will always create conflicts, I try to avoid running any development environments on my mac and usually just spring up a cloud machine, ssh in, and i'm off to work on what i need to work on. At my level of business, it is highly recomeended to work and operate in as much a similar environment as the machines I administer.

There are macos and debian scripts for update and setup that . I chose the following combination for the simple fact that VSCode started to feel clunky, bloated and uninspiring even if it had a plugin for everything. With Docker, this triple combination is all I will need to continue whatever I am working on. This includes installing necessary dependencies, configuring the environment, and ensuring everything works together seamlessly. I will eventually include full setup scripts for macos in brew, windows with chocolately, and debian in apt.  I usually prefer the simple over the extravagant (though precious is precious).

# Setup and Update Instructions

## Prerequisites

### macOS
- Homebrew (Package Manager)
- Git
- Neovim
- Starship Prompt
- Xcode Command Line Tools

### Prerequisites Installation

1. **Install Homebrew:**

    ```sh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

2. **Install Xcode Command Line Tools:**

    ```sh
    xcode-select --install
    ```

3. **Install Git:**

    ```sh
    brew install git
    ```

4. **Install Neovim:**

    ```sh
    brew install neovim
    ```

5. **Install Starship Prompt:**

    ```sh
    brew install starship
    ```

## Running the Update Script

1. **Clone the dotfiles repository:**

    ```sh
    git clone https://github.com/solrey3/dotfiles ~/dotfiles
    ```

2. **Run the update script:**

    ```sh
    cd ~/dotfiles
    ./update.sh
    ```

### What the Update Script Does

- Checks if Oh My Zsh is installed, and installs it if not.
- Updates Starship prompt.
- Installs `stow` if not already installed.
- Clones the dotfiles repository if it does not exist.
- Uses `stow` to create symlinks for all configurations.
- Updates Neovim plugins using LazyVim.
