# Distrobox Dev Environment

Arch Linux-based development container for use with Distrobox.

## Contents

- **Dockerfile** - Arch Linux image with development tools pre-installed
- **setup.sh** - Post-creation script for user-space tools and configurations
- **distrobox.ini** - Assemble manifest for quick container creation

## Quick Start

```bash
# Build the image
podman build -t distrobox-dev ~/.dotfiles/distrobox/dev/

# Create the container
distrobox create -i distrobox-dev -n dev

# Enter the container
distrobox enter dev

# Run the setup script (first time only)
distrobox-setup
```

## Alternative: Using Assemble

```bash
# Build image first
podman build -t distrobox-dev ~/.dotfiles/distrobox/dev/

# Create via assemble manifest
distrobox assemble create --file ~/.dotfiles/distrobox/dev/distrobox.ini
```

## Included Tools

### From Dockerfile (pre-installed)

| Category | Tools |
|----------|-------|
| Development | base-devel, git, gcc, openssl, stow, just, jq |
| Editors | neovim, github-cli, lazygit, tokei |
| Shell | zsh, bash, tmux, starship |
| Navigation | fzf, fd, ripgrep, zoxide, eza, nnn, mc, tree |
| Monitoring | btop, htop, fastfetch, nmap, speedtest-cli |
| Media | ffmpeg, yt-dlp |
| Languages | python, python-pip, nodejs, npm, marksman |
| Fun | figlet, fortune-mod, cowsay, cmatrix |

### From setup.sh (user-space)

| Tool | Description |
|------|-------------|
| lazydocker | Docker TUI |
| Claude Code | AI coding assistant |
| opencode | AI coding tool |
| Fabric | AI prompt framework |
| JetBrainsMono | Nerd Font |
| LazyVim | Neovim configuration |

## Post-Setup

After running `distrobox-setup`:

1. Run `nvim` to complete LazyVim plugin installation
2. Configure AI tools:
   - `claude configure`
   - `fabric --setup`
3. Restart shell or `source ~/.bashrc`

## Using with Dotfiles

To use your stowed dotfiles inside the container:

```bash
# Inside the container, your home directory is shared
cd ~/.dotfiles
./scripts/stow/dotfiles.sh
```
