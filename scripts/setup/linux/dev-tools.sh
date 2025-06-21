#!/usr/bin/env bash
set -euo pipefail

# Script: dev-tools.sh
# Installs linting and formatting tools used in this repo.

# 1. Install shellcheck and shfmt via apt if missing
APT_PKGS=()
if ! command -v shellcheck >/dev/null; then
  APT_PKGS+=(shellcheck)
fi
if ! command -v shfmt >/dev/null; then
  APT_PKGS+=(shfmt)
fi
if [ ${#APT_PKGS[@]} -gt 0 ]; then
  echo "→ Installing ${APT_PKGS[*]} via apt..."
  sudo apt-get update
  sudo apt-get install -y "${APT_PKGS[@]}"
else
  echo "✅ shellcheck and shfmt already installed."
fi

# 2. Install stylua via Cargo if missing
if command -v stylua >/dev/null; then
  echo "✅ stylua is already installed."
else
  if ! command -v cargo >/dev/null; then
    echo "→ Installing Rust and Cargo (via rustup)..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    # shellcheck source=/dev/null
    source "$HOME/.cargo/env"
  fi
  echo "→ Installing stylua via Cargo..."
  cargo install stylua
fi

echo "🎉 Development toolchain setup complete!"
