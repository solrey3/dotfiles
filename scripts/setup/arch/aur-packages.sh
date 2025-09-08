#!/usr/bin/env bash
set -euo pipefail

echo "🔄 Installing AUR packages"
yay -S --noconfirm \
  wezterm ghostty \
  librewolf-bin google-chrome brave-bin \
  bitwarden 1password-cli fabric-ai \
  ttf-jetbrains-mono-nerd
echo "✅ AUR packages installed"
