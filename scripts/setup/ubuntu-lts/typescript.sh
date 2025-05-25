#!/usr/bin/env bash
set -euo pipefail

REQUIRED_NODE_MAJOR=22

install_node() {
  echo "→ Setting up Node.js ${REQUIRED_NODE_MAJOR}.x repo…"
  curl -fsSL https://deb.nodesource.com/setup_${REQUIRED_NODE_MAJOR}.x | sudo -E bash -
  echo "→ Installing nodejs…"
  sudo apt update
  sudo apt install -y nodejs
}

# 1. Check Node.js
if command -v node &>/dev/null; then
  INSTALLED_VERSION=$(node -v | sed 's/^v//')
  INSTALLED_MAJOR=${INSTALLED_VERSION%%.*}
  if [ "$INSTALLED_MAJOR" -eq "$REQUIRED_NODE_MAJOR" ]; then
    echo "✅ Node.js ${INSTALLED_VERSION} is already installed."
  else
    echo "⚠️  Node.js v${INSTALLED_VERSION} found, but v${REQUIRED_NODE_MAJOR}.x required. Reinstalling…"
    install_node
  fi
else
  echo "🔄 Node.js not found. Installing v${REQUIRED_NODE_MAJOR}.x…"
  install_node
fi

# 2. Enable Corepack (for Yarn)
if command -v yarn &>/dev/null; then
  echo "✅ Yarn is already available (version $(yarn --version))."
else
  echo "🔄 Enabling Corepack and preparing Yarn…"
  sudo corepack enable
  corepack prepare yarn@stable --activate
  echo "✅ Yarn installed (version $(yarn --version))."
fi

echo "🎉 Node.js + Yarn setup complete."