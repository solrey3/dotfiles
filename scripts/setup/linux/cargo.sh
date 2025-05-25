#!/usr/bin/env bash
set -euo pipefail

# 1. Install Rust & Cargo if missing
if command -v cargo &>/dev/null; then
  echo "✅ Rust and Cargo are already installed."
else
  echo "🔄 Installing Rust and Cargo (via rustup)…"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  # Load cargo environment for this session
  # shellcheck source=/dev/null
  source "$HOME/.cargo/env"
  echo "✅ Rust and Cargo installation complete."
fi

# 2. Install tokei if missing
if command -v tokei &>/dev/null; then
  echo "✅ tokei is already installed."
else
  echo "🔄 Installing tokei via Cargo…"
  cargo install tokei
  echo "✅ tokei installation complete."
fi

echo "🎉 Cargo & tokei setup complete!"