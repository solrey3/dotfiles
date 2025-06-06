#!/usr/bin/env bash
set -euo pipefail

PKG="wezterm"
KEYRING="/usr/share/keyrings/wezterm-fury.gpg"
LIST="/etc/apt/sources.list.d/wezterm.list"
GPG_URL="https://apt.fury.io/wez/gpg.key"
REPO="deb [signed-by=${KEYRING}] https://apt.fury.io/wez/ * *"

# 1. Check if wezterm is already installed
if command -v wezterm &>/dev/null; then
  echo "✅ wezterm is already installed: $(wezterm --version)"
  exit 0
fi

echo "🔄 Installing wezterm…"

# 2. Ensure keyring directory exists
sudo mkdir -p "$(dirname "$KEYRING")"

# 3. Download & dearmor the GPG key
echo "→ Importing GPG key…"
curl -fsSL "$GPG_URL" \
  | sudo gpg --yes --dearmor -o "$KEYRING"
sudo chmod 644 "$KEYRING"

# 4. Add the apt repository
echo "→ Adding wezterm apt repository…"
echo "$REPO" | sudo tee "$LIST" >/dev/null

# 5. Update and install
echo "→ Updating package lists…"
sudo apt update
echo "→ Installing $PKG…"
sudo apt install -y "$PKG"

# 6. Verify installation
if command -v wezterm &>/dev/null; then
  echo "✅ wezterm installation complete: $(wezterm --version)"
else
  echo "❌ wezterm failed to install."
  exit 1
fi
