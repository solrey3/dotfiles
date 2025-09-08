#!/usr/bin/env bash
set -euo pipefail

nvim_dir="$HOME/.config/nvim"

if [ -d "$nvim_dir" ]; then
  echo "✅ LazyVim already installed at $nvim_dir"
  exit 0
fi

echo "🔄 Installing LazyVim starter template"
git clone https://github.com/LazyVim/starter "$nvim_dir"
echo "→ Removing git metadata"
rm -rf "$nvim_dir/.git"
echo "✅ LazyVim installed"
