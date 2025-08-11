#!/usr/bin/env bash
set -euo pipefail

# Install latest Node.js from NodeSource
if command -v node &>/dev/null; then
  echo "🔄 Updating Node.js to the latest version…"
else
  echo "🔄 Installing Node.js (latest version)…"
fi

curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "✅ Node.js version: $(node --version)"
