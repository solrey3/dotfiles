#!/usr/bin/env bash
set -euo pipefail

PKG="1password-cli"
KEYRING="/usr/share/keyrings/1password-archive-keyring.gpg"
LIST="/etc/apt/sources.list.d/1password.list"
KEY_URL="https://downloads.1password.com/linux/keys/1password.asc"
REPO_URL="https://downloads.1password.com/linux/debian/amd64"

# 1. Check if 1Password CLI is already installed
if dpkg -s "$PKG" &>/dev/null; then
  echo "✅ $PKG is already installed."
else
  echo "🔄 Installing $PKG…"

  # 2. Import the GPG key
  sudo mkdir -p "$(dirname "$KEYRING")"
  curl -sS "$KEY_URL" \
    | sudo gpg --dearmor -o "$KEYRING"

  # 3. Add the repository
  echo "deb [signed-by=$KEYRING] $REPO_URL stable main" \
    | sudo tee "$LIST" >/dev/null

  # 4. Update & install
  sudo apt update
  sudo apt install -y "$PKG"

  echo "✅ $PKG installation complete."
fi

echo "🎉 Done."