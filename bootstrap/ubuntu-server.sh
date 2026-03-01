#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# bootstrap/ubuntu-server.sh — Base Ubuntu Server Bootstrap
# Installs core CLI tools for any Ubuntu LTS server (headless)
# =============================================================================

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.."

echo "🚀 Starting base Ubuntu server bootstrap..."

SCRIPTS=(
  # Core apt packages
  "$ROOT_DIR/scripts/setup/debian/apt.sh"

  # Shell
  "$ROOT_DIR/scripts/setup/debian/zsh.sh"
  "$ROOT_DIR/scripts/setup/linux/starship.sh"

  # Fonts
  "$ROOT_DIR/scripts/setup/debian/jetbrainsmono-nerd-font.sh"

  # Terminal utilities
  "$ROOT_DIR/scripts/setup/debian/fastfetch.sh"

  # Editors
  "$ROOT_DIR/scripts/setup/linux/neovim.sh"
  "$ROOT_DIR/scripts/setup/linux/lazyvim.sh"

  # Core dev tools
  "$ROOT_DIR/scripts/setup/linux/node.sh"
  "$ROOT_DIR/scripts/setup/linux/cargo.sh"
  "$ROOT_DIR/scripts/setup/linux/lazygit.sh"

  # Docker
  "$ROOT_DIR/scripts/setup/ubuntu-lts/docker.sh"
)

for script in "${SCRIPTS[@]}"; do
  if [ ! -f "$script" ]; then
    echo "⚠️  SKIPPING missing script: $script"
    continue
  fi
  echo "▶ Running: $script"
  bash "$script"
done

echo "✅ Base Ubuntu server bootstrap complete!"
