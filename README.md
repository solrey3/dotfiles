# dotfiles
Config files galore! Some preferred, some default, config files mostly for macos bash env.

## About this Repo
This repo contains configuration files, dockerfiles, and/or docker-compose files for services I use. I chose bash over zsh on macOS because, as a DevOps engineer, the systems I am responsible for are mostly Linux-based, which will always have a bash shell. AAAAAAAND, beacuse I have an M2 chip that will always create conflicts, I try to avoid running a dev environments on my mac and usually just spring up a cloud machine, load this configuration, git clone some repos, and i'm off to work on what i need to work on. I need to be able to work and operate in as much a similar environemt as the machines I control.

There is a simple update script here for setting up Alacritty, Tmux, and Neovim on macOS using bash shell. I chose the following combination for the simple fact that VSCode started to feel clunky, bloated and uninspiring even if it had a plugin for everything. With Docker, this triple combination is all I will need to continue whatever I am working on. This includes installing necessary dependencies, configuring the environment, and ensuring everything works together seamlessly. I will eventually include full setup scripts for macos in brew, windows with chocolately, and debian in apt.  I usually prefer the simple over the extravagant (though precious is precious).

### **1. Install Dependencies**

#### **Homebrew**

If you don't have Homebrew installed, install it first:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### **Xcode Command Line Tools**

Install the Xcode Command Line Tools:

```bash
xcode-select --install
```

#### **Essential Packages**

Use Homebrew to install essential packages:

```bash
brew install alacritty tmux neovim git ripgrep
```

### **2. Install JetBrains Mono Nerd Font**

#### **Using Homebrew**

```bash
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
```

### **3. Configure Neovim**

#### **Using LazyVim**

1. **Install LazyVim**: Follow the LazyVim setup instructions if not already done.

### **4. Run Update Script**

Make the script executable:

```bash
chmod +x update-configs.sh
```

Run the update script:

```bash
./update-configs.sh
```

### **5. Summary**

- **Install Dependencies**: Install Alacritty, Tmux, Neovim, ripgrep, and JetBrains Mono Nerd Font.
- **Configure Alacritty**:

 Set up `alacritty.yml` with font, colors, shell, environment variables, and window settings.
- **Configure Tmux**: Set up `tmux.conf` with custom key bindings, mouse support, and appearance settings.
- **Review/Update Tmux Startup Script**: Automate Tmux session and window setup with `tmux_startup.sh`.
- **Configure Neovim**: Set up LazyVim, `nvim-treesitter`, and other plugins.
- **Configure Starship Prompt**: Customize the prompt with `starship.toml` and include the Tokyo Night theme and date-time format.
- **Update Script**: Create an `update-config.sh` script to ensure configurations are up-to-date and correctly symlinked.

By following these steps, you will have a fully configured development environment using Alacritty, Tmux, and Neovim, with a customized Starship prompt, all set up to work seamlessly on macOS and bash shell.
