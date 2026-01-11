# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dual-purpose configuration repository that manages both traditional dotfiles (via GNU Stow) and comprehensive Nix-based system configurations. It supports:
- **Traditional dotfiles**: Stow-managed configs for shells, editors, terminals, and window managers
- **Nix systems**: Full NixOS, macOS (nix-darwin), and home-manager configurations for multiple machines
- **Bootstrap scripts**: Modular setup scripts for Ubuntu/Debian systems

## Key Commands

### GNU Stow Deployments

```bash
# Deploy all dotfiles (from repo root)
./scripts/stow/dotfiles.sh

# Deploy individual configurations
stow -t ~ zsh bash tmux vim              # Shell and terminal configs to ~
stow -t ~/.config starship               # Starship prompt
stow -t ~/.config/nvim nvim              # Neovim (LazyVim)
stow -t ~/.config/alacritty alacritty    # Alacritty terminal
stow -t ~/.config/i3 i3                  # i3 window manager
stow -t ~ wezterm                        # WezTerm config to ~
```

**Available stowable directories**: alacritty, bash, ghostty, hypr, i3, nvim, omarchy, starship, tmux, vim, waybar, wezterm, zsh

### Ubuntu/Debian Bootstrap

```bash
# Full Ubuntu LTS system setup from scripts/ubuntu-lts.sh
./scripts/ubuntu-lts.sh

# Setup scripts organized by platform in scripts/setup/:
# - arch/          Arch Linux specific
# - debian/        Debian/Ubuntu packages (apt, fonts, Docker, etc.)
# - ubuntu-lts/    Ubuntu LTS specific (Docker, Ghostty)
# - linux/         Generic Linux (Cargo, Node, Neovim, Starship, yt-dlp)
# - linux/x86_64/  x86_64 architecture tools (AWS CLI, Fabric AI)
```

### Nix System Management

All Nix commands should be run from the `nix/` directory. The repository uses `just` as a command runner (see `nix/Justfile`).

#### NixOS Systems
```bash
cd nix
just nixos-<hostname>        # Build and switch configuration
just nixos-<hostname>-debug  # Debug build with verbose output

# Available NixOS hosts:
# alpha, bravo, charlie, golf, kilo, mike, november, oscar, papa
```

#### macOS (Darwin) Systems
```bash
cd nix
just darwin-<hostname>        # Build and switch configuration
just darwin-<hostname>-debug  # Debug build with verbose output

# Available Darwin hosts:
# delta (M2 MacBook Air), foxtrot (Early 2013 MBP), juliet (M4 Mac mini), charlie (2017 13" MBP)
```

#### Home Manager (Standalone)
```bash
cd nix
just home-echo   # Raspberry Pi 5 configuration
just home-india  # Steam Deck configuration
```

#### Development Shells
```bash
# Enter specialized development environments (from nix/ directory)
nix develop .#python-data-science   # NumPy, pandas, Jupyter
nix develop .#python-fasthtml       # FastAPI/FastHTML
nix develop .#typescript-devops     # Node.js, TypeScript tools
nix develop .#github-pages          # Static site generators
nix develop .#kali-linux            # Security testing tools
nix develop .#python-devops         # Python DevOps utilities
nix develop .#python-ytdlp          # YouTube download tools
nix develop .#azure-pern-infra      # Azure PERN stack
```

#### Nix Maintenance
```bash
cd nix
just update       # Update flake inputs
just update-lock  # Update flake.lock and commit changes
just fmt          # Format Nix files with alejandra
just gc           # Garbage collect old generations (7+ days)
just history      # Show system profile history
just clean        # Remove build result symlinks
```

## Architecture

### Dual Configuration System

1. **Traditional Dotfiles** (GNU Stow)
   - Top-level directories (alacritty, zsh, nvim, etc.) contain stowable configurations
   - Each directory mirrors the target filesystem structure
   - Deployed via `scripts/stow/dotfiles.sh`

2. **Nix Flake** (`nix/` directory)
   - Comprehensive system configurations using Nix flakes
   - Supports NixOS, macOS (nix-darwin), and standalone home-manager
   - Multiple host configurations with shared modules
   - Development environments for various tech stacks

### Nix Flake Organization

#### Configuration Types
- **nixosConfigurations**: Full NixOS systems (alpha, bravo, charlie, golf, kilo, mike, november, oscar, papa, digitalocean)
- **darwinConfigurations**: macOS systems (charlie, delta, foxtrot, juliet)
- **homeConfigurations**: Standalone home-manager (echo, india)
- **devShells**: Per-architecture development environments

#### Module Structure
- `nix/modules/darwin/`: macOS system modules (apps, system preferences, Nix core)
- `nix/modules/nixos/`: NixOS system modules (desktop environments, hardware, services)
- `nix/modules/linux/`: Linux application packages
- `nix/modules/home/`: Home-manager modules (shells, editors, terminals, development tools)
- `nix/hosts/*/`: Host-specific configurations with hardware and system settings
- `nix/devshells/`: Development environment definitions
- `nix/user.nix`: Central user information (username, email)
- `nix/modules/stylix.nix`: System-wide theming

#### Key Patterns
- **mkHome helper**: Composes home-manager configurations consistently across system types
- **specialArgs**: Passes username, email, and inputs to all modules
- **Input following**: Ensures consistent dependency versions (nixpkgs, home-manager, etc.)

### Bootstrap Script Architecture

Scripts in `scripts/ubuntu-lts.sh` follow a sequential orchestration pattern:
1. Define ordered array of setup scripts
2. Make each script executable
3. Execute in dependency order
4. Skip missing scripts with warnings
5. Deploy stowed dotfiles last

All shell scripts use `set -euo pipefail` for strict error handling.

## Development Notes

- Repository expects to be cloned to `~/.dotfiles`
- Nix configurations are in `nix/` subdirectory and should be built from there
- Stow operations use XDG-compliant paths
- Test Nix changes with debug builds first (e.g., `just darwin-delta-debug`)
- Use `nix flake check` from `nix/` to validate flake syntax before building