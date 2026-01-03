#!/usr/bin/env bash
# Setup the Nix environment so `nix fmt` and `nix flake check` can run.
# This installs Nix in single-user mode and enables flakes.
set -e

# Install Nix if not already installed
if ! command -v nix >/dev/null 2>&1; then
  echo "Installing Nix..."
  sh <(curl -L https://nixos.org/nix/install) --no-daemon
  . "$HOME/.nix-profile/etc/profile.d/nix.sh"
else
  echo "Nix already installed"
fi

# Ensure flakes are enabled
mkdir -p "$HOME/.config/nix"
if ! grep -q "experimental-features" "$HOME/.config/nix/nix.conf" 2>/dev/null; then
  echo "experimental-features = nix-command flakes" >> "$HOME/.config/nix/nix.conf"
fi

# Install alejandra for nix fmt
nix profile install --inputs-from . nixpkgs#alejandra

echo "Nix environment setup complete."
