#!/usr/bin/env bash
set -euo pipefail

NVM_VERSION="v0.39.7"
NODE_VERSION="22" # You can change this to 20, 18, etc.

# 1. Install nvm if not present
if [ -d "$HOME/.nvm" ]; then
  echo "✅ nvm is already installed."
else
  echo "→ Installing nvm $NVM_VERSION..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash
fi

# 2. Source nvm into the current shell
export NVM_DIR="$HOME/.nvm"
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# 3. Install Node.js via nvm
if nvm ls "$NODE_VERSION" | grep -q "N/A"; then
  echo "→ Installing Node.js v$NODE_VERSION..."
  nvm install "$NODE_VERSION"
else
  echo "✅ Node.js v$NODE_VERSION is already installed."
fi

nvm use "$NODE_VERSION"
nvm alias default "$NODE_VERSION"

# 4. Install Yarn globally using npm
if command -v yarn &>/dev/null; then
  echo "✅ Yarn is already installed: $(yarn --version)"
else
  echo "→ Installing Yarn globally..."
  npm install -g yarn
  echo "✅ Yarn installed: $(yarn --version)"
fi

echo "🎉 Node.js + Yarn setup via nvm complete."

