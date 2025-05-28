#!/usr/bin/env bash
set -euo pipefail

NVM_VERSION="v0.39.7"
NODE_VERSION="22"

# 1. Install nvm if missing
if [ ! -d "$HOME/.nvm" ]; then
  echo "→ Installing nvm $NVM_VERSION..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash
fi

# 2. Load nvm
export NVM_DIR="$HOME/.nvm"
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# 3. Install Node.js if missing
if ! nvm ls "$NODE_VERSION" | grep -q "v$NODE_VERSION"; then
  echo "→ Installing Node.js v$NODE_VERSION..."
  nvm install "$NODE_VERSION"
fi

nvm use "$NODE_VERSION"
nvm alias default "$NODE_VERSION"

# 4. Install Yarn globally
if command -v yarn &>/dev/null; then
  echo "✅ Yarn is already installed (v$(yarn --version))"
else
  echo "→ Installing Yarn..."
  npm install -g yarn
fi

# 5. Install DevOps + Linting Tools
echo "→ Installing global tools via Yarn..."
yarn global add \
  cdktf \
  cdk8s-cli \
  pulumi \
  playwright \
  dotenv \
  markdownlint-cli2 \
  eslint \
  prettier

echo "✅ Installed tools:"
yarn global list | grep -E "cdktf|cdk8s-cli|pulumi|playwright|dotenv|markdownlint|eslint|prettier"

echo "🎉 DevOps + Linter environment setup complete!"
