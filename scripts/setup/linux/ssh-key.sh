#!/usr/bin/env bash
set -euo pipefail

echo "🔄 Generating SSH key"
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  command -v ssh-keygen &>/dev/null || {
    echo "ssh-keygen not installed"
    exit 1
  }
  mkdir -p "$HOME/.ssh"
  ssh-keygen -t ed25519 -C "solrey3@solrey3.com" -f "$HOME/.ssh/id_ed25519" -N ""
  echo "✅ SSH key generated"
else
  echo "✅ SSH key already exists"
fi
