#!/usr/bin/env bash
set -euo pipefail

NEOVIM_VERSION="v0.10.4"
ARCHIVE="nvim-linux-x86_64.tar.gz"
DIR="nvim-linux-x86_64"
INSTALL_PATH="/usr/local/$DIR"
SYMLINK="/usr/local/bin/nvim"

# Check if nvim is already installed at the correct version
if command -v nvim &>/dev/null; then
  INSTALLED_VERSION=$(nvim --version | head -n1 | awk '{print $2}')
  if [ "$INSTALLED_VERSION" = "$NEOVIM_VERSION" ]; then
    echo "✅ Neovim $NEOVIM_VERSION is already installed."
    exit 0
  else
    echo "⚠️  Neovim is installed (version $INSTALLED_VERSION), but not $NEOVIM_VERSION. Upgrading…"
  fi
else
  echo "🔄 Installing Neovim $NEOVIM_VERSION…"
fi

# 1. Download the release archive
wget -q "https://github.com/neovim/neovim/releases/download/$NEOVIM_VERSION/$ARCHIVE"

# 2. Extract it
tar -xzf "$ARCHIVE"

# 3. Move into place (overwrite if needed)
sudo rm -rf "$INSTALL_PATH"
sudo mv "$DIR" "$INSTALL_PATH"

# 4. (Re)create symlink
if [ -L "$SYMLINK" ] || [ -e "$SYMLINK" ]; then
  sudo rm -f "$SYMLINK"
fi
sudo ln -s "$INSTALL_PATH/bin/nvim" "$SYMLINK"

# 5. Cleanup
rm -f "$ARCHIVE"

# 6. Verify
echo "✅ Neovim installed. Version:"
nvim --version | head -n1

echo "🎉 Done."