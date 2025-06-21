# Dotfiles

Personal configuration for Linux desktops using GNU Stow for deployment. These files are tested on Debian-based distributions and include optional setup scripts to bootstrap common development tools.

## Contents

- **Shells**: Bash and Zsh configurations
- **Editors**: Neovim (LazyVim) and Vim
- **Terminals**: Alacritty, Ghostty, WezTerm
- **Window managers**: i3 and Hyprland with Waybar
- **Nix**: Minimal flake for reproducible environments
- **Scripts**: Helpers for installing packages and managing symlinks

## Usage

Clone the repo and deploy the configs with GNU Stow:

```bash
git clone https://github.com/yourname/dotfiles ~/.dotfiles
cd ~/.dotfiles
./scripts/stow/dotfiles.sh
```

For a full system bootstrap on Ubuntu LTS, run:

```bash
./scripts/ubuntu-lts.sh
```

## Nix

Enter a development shell with:

```bash
nix develop
```

## License

This project is licensed under the terms of the GNU GPL v3.0. See [LICENSE](./LICENSE) for details.
