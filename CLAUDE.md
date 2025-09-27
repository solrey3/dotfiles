# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for Linux desktops that uses GNU Stow for symlink management. The repository contains configuration files for shells, editors, terminals, window managers, and development tools, along with setup scripts for bootstrapping systems.

## Key Commands

### Deploying Configurations
```bash
# Deploy all dotfiles using stow
./scripts/stow/dotfiles.sh

# Deploy specific configuration (run from repo root)
stow -t ~ zsh                    # Zsh configuration
stow -t ~/.config starship      # Starship prompt
stow -t ~/.config/nvim nvim     # Neovim configuration
stow -t ~/.config/alacritty alacritty  # Alacritty terminal
stow -t ~/.config/i3 i3         # i3 window manager
```

### System Bootstrap
```bash
# Full Ubuntu LTS system setup (runs 41+ setup scripts)
./scripts/ubuntu-lts.sh

# Individual setup scripts are in scripts/setup/ organized by:
# - debian/        - Debian/Ubuntu specific packages
# - ubuntu-lts/    - Ubuntu LTS specific
# - linux/         - Generic Linux
# - linux/x86_64/  - x86_64 specific tools
```

### Development Environment
```bash
# Enter Nix development shell (if nix is available)
nix develop
```

## Architecture

### Directory Structure
- **Configuration directories**: Each top-level directory (zsh, bash, nvim, etc.) contains stowable configuration files
- **scripts/setup/**: Modular installation scripts organized by OS/architecture
- **scripts/stow/**: Stow deployment scripts
- **scripts/ubuntu-lts.sh**: Master bootstrap script that orchestrates setup

### Stow Integration
The repository uses GNU Stow for symlink management. Each configuration directory is designed to be stowed to its appropriate target:
- Shell configs (zsh, bash) → `~`
- Editor configs (nvim) → `~/.config/nvim`
- Terminal configs (alacritty) → `~/.config/alacritty`
- Desktop configs (i3, waybar, hypr) → `~/.config/`

### Setup Script Architecture
Setup scripts follow a modular pattern:
1. **ubuntu-lts.sh** - Master orchestrator script
2. **scripts/setup/** - Individual component installers
3. **scripts/stow/dotfiles.sh** - Final configuration deployment

The master script defines an ordered array of scripts to run, allowing for commented out optional components and dependency management.

## Development Notes

- All shell scripts use `set -euo pipefail` for strict error handling
- Setup scripts are made executable before running
- The repository expects to be cloned to `~/.dotfiles`
- Stow operations target appropriate config directories based on XDG conventions
- Missing setup scripts are skipped with warnings rather than failing the entire process