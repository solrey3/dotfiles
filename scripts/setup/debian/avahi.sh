#!/usr/bin/env bash
set -euo pipefail

# Packages to ensure are installed
packages=(avahi-daemon avahi-utils)
missing=()

# Check each package
for pkg in "${packages[@]}"; do
  if ! dpkg -s "$pkg" &>/dev/null; then
    missing+=("$pkg")
  fi
done

# Install missing packages if any
if [ "${#missing[@]}" -gt 0 ]; then
  echo "Installing missing packages: ${missing[*]}"
  sudo apt update
  sudo apt install -y "${missing[@]}"
else
  echo "All required packages are already installed."
fi

# Enable and start the Avahi daemon
echo "Enabling and starting avahi-daemon service…"
sudo systemctl enable --now avahi-daemon

echo "Done."
