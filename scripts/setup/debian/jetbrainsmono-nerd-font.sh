#!/usr/bin/env bash
set -euo pipefail

FONT_DIR="$HOME/.local/share/fonts/jetbrainsmono-nerd"
ZIP_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/JetBrainsMono.zip"
TMP_ZIP="/tmp/JetBrainsMono.zip"

# Ensure required packages are installed
needed=(fontconfig wget unzip)
missing=()
for pkg in "${needed[@]}"; do
  if ! dpkg -s "$pkg" &>/dev/null; then
    missing+=("$pkg")
  fi
done

if [ "${#missing[@]}" -gt 0 ]; then
  echo "→ Installing missing packages: ${missing[*]}"
  sudo apt-get update
  sudo apt-get install -y "${missing[@]}"
else
  echo "✅ All prerequisites (fontconfig, wget, unzip) are installed."
fi

# Install JetBrains Mono Nerd Font if not already there
if compgen -G "$FONT_DIR/*.ttf" >/dev/null 2>&1; then
  echo "✅ JetBrains Mono Nerd Font already installed in $FONT_DIR."
else
  echo "→ Installing JetBrains Mono Nerd Font…"
  mkdir -p "$FONT_DIR"
  wget -qO "$TMP_ZIP" "$ZIP_URL"
  unzip -q "$TMP_ZIP" -d "$FONT_DIR"
  rm -f "$TMP_ZIP"
fi

# Refresh font cache
echo "→ Refreshing font cache…"
fc-cache -f -v

echo "🎉 JetBrains Mono Nerd Font setup complete!"

