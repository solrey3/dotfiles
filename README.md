# 🛠️ My Dotfiles

A cross-platform, modular setup to manage system and dev environment configs using `stow`, `Nix`, and shell scripts. Supports Linux (Debian/Ubuntu) and macOS.

## 📁 Directory Structure

```
.
├── .gitignore               → Global Git ignore rules
├── README.md                → This file
├── LICENSE                  → MIT License
├── flake.nix                → Nix flake entrypoint
│
├── alacritty/               → Alacritty terminal configs (.toml and .yml)
├── bash/                    → Bash login and runtime configs
├── ghostty/                 → Ghostty terminal config
├── hypr/                    → Hyprland window manager config
├── i3/                      → i3 window manager config (used with XFCE+i3)
├── nix/                     → Nix CLI configuration
├── nvim/                    → Neovim setup (LazyVim-based)
│   ├── init.lua             → Main config
│   ├── lua/config/          → Autocmds, keymaps, options, plugin loader
│   ├── lua/plugins/         → Plugin overrides & custom plugins
│   └── stylua.toml          → Formatter config
├── starship/                → Starship prompt config
├── stow/                    → Local stow ignore rules
├── tmux/                    → Tmux config and startup script
├── vim/                     → Minimal legacy Vim config
├── wezterm/                 → WezTerm terminal configuration
├── zsh/                     → Zsh shell config (.zshrc)
├── waybar/                  → Waybar config and custom scripts
│
├── scripts/                 → Bootstrap scripts for setting up tools and environments
│   ├── setup/
│   │   ├── debian/          → For Debian-based distros (1Password, Docker, Azure CLI, etc.)
│   │   ├── linux/           → Shared Linux tools (Neovim, Brave, yt-dlp, k9s, etc.)
│   │   ├── ubuntu-lts/      → Ubuntu LTS-specific setup
│   ├── stow/                → Helpers to automate symlink deployment
│   └── ubuntu-lts.sh        → One-shot setup script for Ubuntu LTS systems
```

## ⚙️ Features

- 🐚 **Shell config:** Bash, Zsh
- 📝 **Editor setup:** Neovim (LazyVim) and Vim
- 🖥️ **Terminal configs:** Alacritty, Ghostty, WezTerm
- 🪟 **WM support:** i3, Hyprland, Waybar
- ❄️ **Nix flake** support for reproducible environments
- 🧰 **Dev tooling:** Docker, Kubernetes, Conda, yt-dlp, etc.
- 🔗 **Symlink automation** using GNU Stow

## 🚀 Quickstart

1. Clone the repo:

   ```bash
   git clone https://github.com/yourname/dotfiles ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Deploy dotfiles using stow:

   ```bash
   ./scripts/stow/dotfiles.sh
   ```

3. Run setup scripts for your environment:

   ```bash
   ./scripts/setup/debian/docker.sh
   ./scripts/setup/debian/zsh.sh
   ```

## ❄️ Nix Flake Usage

If using Nix:

```bash
nix develop
```

Or build system config (for NixOS):

```bash
nix build .#nixosConfigurations.myhostname.config.system.build.toplevel
```

## 📄 License

MIT — See [`LICENSE`](./LICENSE)
