#!/usr/bin/env bash
set -euo pipefail

FONT_PKG="fontconfig"
FONT_DIR="$HOME/.local/share/fonts/jetbrainsmono-nerd"
ZIP_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/JetBrainsMono.zip"
TMP_ZIP="/tmp/JetBrainsMono.zip"

# 1. Ensure fontconfig is installed
if dpkg -s "$FONT_PKG" &>/dev/null; then
  echo "✅ $FONT_PKG is already installed."
else
  echo "🔄 Installing $FONT_PKG…"
  sudo apt update
  sudo apt install -y "$FONT_PKG"
fi

# 2. Install JetBrains Mono Nerd Font
if [ -d "$FONT_DIR" ] && compgen -G "$FONT_DIR/*.ttf" > /dev/null; then
  echo "✅ JetBrains Mono Nerd Font already installed in $FONT_DIR."
else
  echo "🔄 Installing JetBrains Mono Nerd Font…"
  mkdir -p "$FONT_DIR"
  wget -qO "$TMP_ZIP" "$ZIP_URL"
  unzip -q "$TMP_ZIP" -d "$FONT_DIR"
  rm -f "$TMP_ZIP"
fi

# 3. Refresh font cache
echo "→ Refreshing font cache…"
fc-cache -f -v

echo "🎉 JetBrains Mono Nerd Font setup complete!"