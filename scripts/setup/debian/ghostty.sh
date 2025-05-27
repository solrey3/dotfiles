#!/usr/bin/env bash
set -euo pipefail

REPO_LIST="/etc/apt/sources.list.d/home:clayrisser:bookworm.list"
GPG_KEY="/etc/apt/trusted.gpg.d/home_clayrisser_bookworm.gpg"
PKG="ghostty"

# 1. Check if ghostty is already installed
if command -v ghostty &>/dev/null; then
  echo "✅ ghostty is already installed: $(ghostty --version || echo '[version not available]')"
  exit 0
fi

# 2. Add the repository
if [ ! -f "$REPO_LIST" ]; then
  echo "→ Adding Ghostty APT repository…"
  echo 'deb http://download.opensuse.org/repositories/home:/clayrisser:/bookworm/Debian_12/ /' |
    sudo tee "$REPO_LIST" >/dev/null
else
  echo "✅ APT source already exists: $REPO_LIST"
fi

# 3. Add the GPG key
if [ ! -f "$GPG_KEY" ]; then
  echo "→ Importing GPG key for repository…"
  curl -fsSL https://download.opensuse.org/repositories/home:clayrisser:bookworm/Debian_12/Release.key |
    gpg --dearmor | sudo tee "$GPG_KEY" >/dev/null
  sudo chmod 644 "$GPG_KEY"
else
  echo "✅ GPG key already exists: $GPG_KEY"
fi

# 4. Install ghostty
echo "→ Updating package index and installing ghostty…"
sudo apt update
sudo apt install -y "$PKG"

# 5. Verify installation
if command -v ghostty &>/dev/null; then
  echo "✅ ghostty installed successfully!"
else
  echo "❌ ghostty installation failed."
  exit 1
fi
