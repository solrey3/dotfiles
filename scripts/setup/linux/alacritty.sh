#!/usr/bin/env bash
set -euo pipefail

# 1. Ensure Rust & Cargo are installed
if ! command -v cargo &>/dev/null; then
  echo "🔄 Installing Rust and Cargo (via rustup)…"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  # Load into current shell
  # shellcheck source=/dev/null
  source "$HOME/.cargo/env"
  echo "✅ Rust and Cargo installation complete."
fi

# 2. Install Alacritty if missing
if command -v alacritty &>/dev/null; then
  echo "✅ Alacritty is already installed."
else
  echo "🔄 Installing Alacritty via Cargo…"
  cargo install alacritty
  echo "✅ Alacritty installation complete."
fi

echo "🎉 Alacritty setup complete!"