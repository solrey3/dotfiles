#!/usr/bin/env bash
set -euo pipefail

echo "🔄 Ensuring Neovim is up to date"

# 0. Discover latest Neovim release tag (e.g. "v0.10.5")
echo "→ Fetching latest Neovim version…"
NEOVIM_VERSION=$(curl -fsSL https://api.github.com/repos/neovim/neovim/releases/latest | grep -Po '"tag_name": *"\K(.*)(?=")')
if [ -z "$NEOVIM_VERSION" ]; then
  echo "❌ Failed to determine latest Neovim version."
  exit 1
fi
echo "→ Latest version is $NEOVIM_VERSION"

ARCHIVE="nvim-linux-x86_64.tar.gz"
DIR="nvim-linux-x86_64"
INSTALL_PATH="/usr/local/$DIR"
SYMLINK="/usr/local/bin/nvim"

# 1. Check existing installation
if command -v nvim &>/dev/null; then
  INSTALLED_VERSION=$(nvim --version | head -n1 | awk '{print $2}')
  if [ "$INSTALLED_VERSION" = "${NEOVIM_VERSION#v}" ]; then
    echo "✅ Neovim $INSTALLED_VERSION is already the latest."
    exit 0
  else
    echo "⚠️  Neovim is installed (version $INSTALLED_VERSION), upgrading to $NEOVIM_VERSION…"
  fi
else
  echo "🔄 Installing Neovim $NEOVIM_VERSION…"
fi

# 2. Download the release archive
URL="https://github.com/neovim/neovim/releases/download/${NEOVIM_VERSION}/${ARCHIVE}"
echo "→ Downloading from $URL"
wget -q "$URL" -O "$ARCHIVE"

# 3. Extract and move into place
tar -xzf "$ARCHIVE"
sudo rm -rf "$INSTALL_PATH"
sudo mv "$DIR" "$INSTALL_PATH"

# 4. Symlink the binary
if [ -L "$SYMLINK" ] || [ -e "$SYMLINK" ]; then
  sudo rm -f "$SYMLINK"
fi
sudo ln -s "$INSTALL_PATH/bin/nvim" "$SYMLINK"

# 5. Cleanup
rm -f "$ARCHIVE"

# 6. Verify
echo "✅ Neovim installed. Version:"
nvim --version | head -n1

echo "🎉 Neovim setup complete"
