#!/usr/bin/env bash
set -euo pipefail

# Script: lazygit.sh
# Installs lazygit if not already present.

# 1. Check if lazygit is already installed
if command -v lazygit &>/dev/null; then
  echo "✅ lazygit is already installed: $(lazygit --version 2>&1)"
  exit 0
else
  echo "🔄 Installing lazygit…"
fi

# 2. Fetch latest version tag from GitHub
echo "→ Fetching latest lazygit version…"
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" \
  | grep -Po '"tag_name": *"v\K[^"]*')
echo "→ Latest version is v${LAZYGIT_VERSION}"

# 3. Download the tarball
ARCHIVE="lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
echo "→ Downloading lazygit v${LAZYGIT_VERSION}…"
curl -fsSL -o lazygit.tar.gz \
  "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/${ARCHIVE}"

# 4. Extract the binary
echo "→ Extracting binary…"
tar -xzf lazygit.tar.gz lazygit

# 5. Install to /usr/local/bin
echo "→ Installing to /usr/local/bin…"
sudo install lazygit -D -t /usr/local/bin/

# 6. Cleanup
rm -f lazygit.tar.gz lazygit

echo "✅ lazygit v${LAZYGIT_VERSION} installation complete!"