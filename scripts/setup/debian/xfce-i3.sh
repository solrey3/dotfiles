#!/usr/bin/env bash
set -euo pipefail

# List of required packages
packages=(
  i3 i3status i3lock dmenu xinit x11-xserver-utils feh
  fonts-font-awesome fonts-ubuntu xterm network-manager-gnome
  lightdm lightdm-gtk-greeter
  lxappearance thunar xfce4-terminal
)

# Collect any missing packages
missing=()
for pkg in "${packages[@]}"; do
  if ! dpkg -s "$pkg" &>/dev/null; then
    missing+=("$pkg")
  fi
done

# Install missing packages
if [ "${#missing[@]}" -gt 0 ]; then
  echo "→ Installing missing packages: ${missing[*]}"
  sudo apt update
  sudo apt install -y "${missing[@]}"
else
  echo "✅ All XFCE+i3 packages are already installed."
fi

# Enable LightDM if not already enabled
if ! systemctl is-enabled lightdm &>/dev/null; then
  echo "→ Enabling LightDM display manager…"
  sudo systemctl enable lightdm
else
  echo "✅ LightDM is already enabled."
fi

# Prompt to configure i3
CONFIG_PATH="$HOME/.config/i3/config"
echo "🎨 Opening your i3 config for editing: $CONFIG_PATH"
mkdir -p "$(dirname "$CONFIG_PATH")"
if [ ! -f "$CONFIG_PATH" ]; then
  echo "# i3 configuration generated on $(date)" > "$CONFIG_PATH"
fi
nvim "$CONFIG_PATH"

echo "🎉 XFCE+i3 setup complete!"
