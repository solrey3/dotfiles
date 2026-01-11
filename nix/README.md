# nix-config

This repository contains a Nix flake that provides comprehensive configurations for all Linux and macOS machines I manage, alongside development shell environments. This flake ensures consistent system setups and development experiences across all machines running Nix.

## Features

1. **System Configuration**: Centralized configuration management for all my machines. As long as Nix is installed, flakes handle system setup and maintenance, simplifying consistency across environments.
2. **Development Shell Environments**: Pre-configured development shells for various programming languages and tools, ensuring all necessary dependencies are readily available and correctly set up.

## Installation Instructions

### Installing Nix

#### NixOS
To install NixOS, refer to the official [NixOS download page](https://nixos.org/download/#nix-more) for detailed instructions.

#### macOS
Install Xcode and Homebrew
```sh
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install Nix on macOS using the following command:
```sh
sh <(curl -L https://nixos.org/nix/install)
```

#### Linux

**Multi-user Installation (Recommended)**

For Linux systems with systemd and SELinux disabled, and where sudo authentication is available:
```sh
sh <(curl -L https://nixos.org/nix/install) --daemon
```

**Single-user Installation**

If the multi-user installation is not feasible:
```sh
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```
This installs Nix as a single-user setup, owned by the invoking user. Run it under your usual account, not as root. The script will use sudo to create `/nix` if it doesn’t already exist.

## Enabling Nix Flakes

To enable Nix flakes, add the following configuration to your `nix.conf` file:
```sh
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

## Managed Hosts

- **alpha**: Intel Core i5-3570K with NVIDIA GeForce GTX 660 and 32GB RAM running NixOS.
- **bravo**: AMD Ryzen 9 3900X and NVIDIA GeForce RTX 3070 and 32GB RAM running NixOS.
- **charlie**: 2017 Intel 13-inch MacBook Pro, two Thunderbolt 3 ports (**MacBookPro14,1**).
- **delta**: 2022 M2 13-inch MacBook Air (**Mac14,2**).
- **echo**: Raspberry Pi 5 running RaspberryPi OS using home-manager.
- **foxtrot**: Early 2013 13-inch Retina MacBook Pro (**MacBookPro10,2**).
- **golf**: Late-2011 15-inch MacBook Pro (**MacBookPro8,2**).
- **hotel**: Digital Ocean droplet originally running Ubuntu injected to run nixos.
- **india**: Steam Deck OLED (Galileo) running SteamOS using home-manager.
- **juliet**: 2024 base M4 Mac Mini (**Mac16,10**).
- **kilo**: Beelink EQR5 with AMD Ryzen 7 5825U running Ubuntu LTS.
- **lima**: Beelink EQR5 worker node.
- **mike**: Beelink EQR5 running NixOS 25.05 with KDE Plasma.
- **november**: Late 2014 Mac Mini (**Macmini7,1**).

## Other Configurations
- **digitalocean**: Uses nixos-anywhere to install NixOS on a Linux droplet

## Updating Hosts/Configurations

To update configurations on any host, utilize the provided Justfile to run the necessary commands, ensuring that all machines have the latest settings applied.

## Module Overview

### System Modules
- **darwin/**
  - `nix-core`
  - `system`: macOS system configuration.
  - `apps`: macOS applications.
  - `apps-aarch64`: Apple Silicon-specific apps.
  - `host-users`: macOS user configuration.
- **linux/**
  - `apps-gui`: GUI applications.
  - `apps-gui-x86_64`: x86_64-specific GUI applications.
- **nixos/**
  - `base`: NixOS base configuration.
  - `hyprland`: NixOS Hyprland configuration.
  - `nvidia-legacy_470`: Legacy NVIDIA driver for GeForce GTX.
  - `nvidia-stable`: Stable NVIDIA driver for GeForce RTX.
  - `plasma`: KDE Plasma desktop environment.
  - `xfce4`: Xfce desktop environment.
- **stylix**: Stylix configuration.

### Home Modules
- **home/**
  - `default`
  - `core`
  - `zsh`
  - `bash`
  - `alacritty`
  - `git`
  - `neovim`
  - `ssh`
  - `starship`
  - `tmux`

#### Dotfiles (Home Configuration Files)

Additional configuration files are available for:
- `hypr`
- `neovim`
- `waybar`

## Development Shells

The flake exposes several ready-to-use development shells:

- **github-pages** – tools for building static sites with GitHub Pages.
- **kali-linux** – packages commonly used for security testing.
- **python-data-science** – a data science stack with NumPy, pandas, and Jupyter.
- **python-fasthtml** – environment for building FastAPI applications.
- **typescript-devops** – Node.js tooling for TypeScript projects.

Run `nix develop .#<name>` to enter one of these environments.

## Activating a DevShell

With Nix installed, activate a development environment using the `nix develop` command:

```sh
nix develop github:solrey3/nix-config#python-data-science
```

This command loads the specified development environment, complete with all tools and dependencies defined in the flake.
