#!/usr/bin/env bash
set -euo pipefail

echo "🔄 Installing yay AUR helper"
if ! command -v yay &>/dev/null; then
  sudo pacman -S --needed --noconfirm base-devel git
  temp_dir="$(mktemp -d)"
  git clone https://aur.archlinux.org/yay.git "$temp_dir/yay"
  (cd "$temp_dir/yay" && makepkg -si --noconfirm)
  rm -rf "$temp_dir"
else
  echo "✅ yay already installed"
fi
