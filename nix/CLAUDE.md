# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This repository contains a comprehensive Nix flake configuration for managing multiple machines running NixOS, macOS (via nix-darwin), and home-manager configurations. It provides consistent system configurations and development environments across all platforms.

## Development Commands

### Building and Switching Configurations

The repository uses `just` as a command runner. The Justfile contains targets for building and switching configurations:

#### macOS (Darwin) Systems
- `just darwin-delta` - Build and switch configuration for delta (M2 MacBook Air)
- `just darwin-foxtrot` - Build and switch configuration for foxtrot (Early 2013 MacBook Pro)
- `just darwin-juliet` - Build and switch configuration for juliet (M4 Mac Mini)
- `just darwin-delta-debug` - Debug build for delta with verbose output
- `just darwin-foxtrot-debug` - Debug build for foxtrot with verbose output
- `just darwin-juliet-debug` - Debug build for juliet with verbose output

#### NixOS Systems
- `just nixos-alpha` - Build and switch configuration for alpha (Intel desktop)
- `just nixos-bravo` - Build and switch configuration for bravo (AMD Ryzen desktop)
- `just nixos-charlie` - Build and switch configuration for charlie (MacBook Pro running NixOS)
- `just nixos-golf` - Build and switch configuration for golf (Late 2011 MacBook Pro)
- `just nixos-kilo` - Build and switch configuration for kilo (Beelink EQR5)
- `just nixos-mike` - Build and switch configuration for mike (Beelink EQR5)
- `just nixos-november` - Build and switch configuration for november (Late 2014 Mac Mini)
- `just nixos-oscar` - Build and switch configuration for oscar
- Debug versions available by appending `-debug` to any nixos command

#### Home Manager Configurations
- `just home-echo` - Switch home-manager configuration for echo (Raspberry Pi 5)
- `just home-india` - Switch home-manager configuration for india (Steam Deck)

### Maintenance Commands
- `just update` - Update flake inputs
- `just update-lock` - Update flake.lock and commit changes
- `just fmt` - Format all Nix files using alejandra
- `just gc` - Garbage collect old generations and unused store entries
- `just history` - Show system profile history
- `just clean` - Remove build result symlinks

### Development Shells
Enter development environments with `nix develop .#<name>`:
- `nix develop .#python-data-science` - NumPy, pandas, Jupyter stack
- `nix develop .#python-fasthtml` - FastAPI/FastHTML development
- `nix develop .#typescript-devops` - Node.js and TypeScript tools
- `nix develop .#github-pages` - Static site building tools
- `nix develop .#kali-linux` - Security testing packages
- `nix develop .#python-devops` - Python DevOps tools
- `nix develop .#python-ytdlp` - YouTube downloading tools
- `nix develop .#azure-pern-infra` - Azure PERN stack infrastructure

## Architecture Overview

### Configuration Structure
The flake is organized into distinct output types:
- `nixosConfigurations` - Full NixOS system configurations
- `darwinConfigurations` - macOS system configurations via nix-darwin
- `homeConfigurations` - Standalone home-manager configurations
- `devShells` - Development environment definitions

### Module Organization

#### System Modules
- **darwin/**: macOS-specific system configuration
  - `nix-core.nix` - Base Nix configuration (flakes, GC, unfree packages)
  - `system.nix` - macOS system preferences, dock, finder, trackpad settings
  - `apps.nix` - Standard macOS applications
  - `apps-aarch64.nix` - Apple Silicon-specific applications
  - `host-users.nix` - User account configuration

- **nixos/**: NixOS-specific system modules
  - `base.nix` - Base NixOS configuration
  - Desktop environments: `plasma.nix`, `xfce4.nix`, `hyprland.nix`
  - Hardware: `nvidia-stable.nix`, `nvidia-legacy_470.nix`
  - Services: `docker.nix`, `jellyfin.nix`, `navidrome.nix`, `ollama.nix`

- **linux/**: Linux application packages
  - `apps-gui.nix` - GUI applications for Linux
  - `apps-gui-x86_64.nix` - x86_64-specific GUI applications

#### Home Manager Modules
- **home/**: User environment configuration
  - `core.nix` - Essential CLI tools, development packages, fonts
  - Shell configuration: `zsh.nix`, `bash.nix`, `starship.nix`
  - Terminal emulators: `alacritty.nix`, `ghostty.nix`, `wezterm.nix`
  - Development tools: `git.nix`, `neovim.nix`, `tmux.nix`
  - Platform-specific: `darwin.nix`, `linux.nix`, `linux-desktop.nix`

#### Global Configuration
- `user.nix` - Central user information (username, email)
- `modules/stylix.nix` - System-wide theming configuration

### Host-Specific Configurations
Each host has its own directory under `hosts/` containing:
- `configuration.nix` - Host-specific system configuration
- `hardware-configuration.nix` - Hardware-specific settings (for NixOS)
- `README.md` - Host documentation

### Key Design Patterns

#### Module Composition
The flake uses a `mkHome` helper function to compose home-manager configurations consistently across all system types. This ensures home-manager is properly integrated whether running standalone or as part of a system configuration.

#### Input Management
All external dependencies are centrally managed in the flake inputs with version pinning:
- `nixpkgs` follows nixos-25.05 stable
- `nixpkgs-unstable` for bleeding-edge packages 
- `nixpkgs-darwin` follows nixpkgs-25.05-darwin for macOS-specific package versions
- `home-manager` follows release-25.05 but uses nixpkgs-unstable
- External inputs: `stylix`, `disko`, `zen-browser`, `omarchy-nix`, `flake-utils`
- Input following ensures consistent dependency versions

#### Special Arguments
The `specialArgs` pattern passes common configuration (username, email, inputs) to all modules, enabling consistent access to global settings throughout the configuration tree.

## Testing Changes
- Always test configuration changes with debug builds first (e.g., `just darwin-delta-debug`)
- Use `nix flake check` to validate flake syntax before building
- For new modules, test in isolation before integrating into host configurations