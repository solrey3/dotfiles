#!/usr/bin/env bash
set -euo pipefail

PKG="google-cloud-sdk"
KEYRING="/usr/share/keyrings/cloud.google.gpg"
LIST="/etc/apt/sources.list.d/google-cloud-sdk.list"

# 1. Check if gcloud is already installed
if command -v gcloud &>/dev/null; then
  echo "✅ gcloud is already installed: $(gcloud --version | head -n1)"
  exit 0
fi

echo "🔄 Installing Google Cloud SDK…"

# 2. Ensure keyrings directory exists
echo "→ Creating keyring directory (if needed)…"
sudo mkdir -p "$(dirname "$KEYRING")"

# 3. Import Google's public key (modern method)
echo "→ Importing GPG key…"
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg |
  gpg --dearmor | sudo tee "$KEYRING" >/dev/null
sudo chmod 644 "$KEYRING"

# 4. Add the Cloud SDK apt repository
echo "→ Adding Google Cloud SDK repository…"
echo "deb [signed-by=$KEYRING] http://packages.cloud.google.com/apt cloud-sdk main" |
  sudo tee "$LIST" >/dev/null

# 5. Update package index and install
echo "→ Updating package index…"
sudo apt update
echo "→ Installing $PKG…"
sudo apt install -y "$PKG"

# 6. Verify installation
if command -v gcloud &>/dev/null; then
  echo "✅ Google Cloud SDK installation complete: $(gcloud --version | head -n1)"
else
  echo "❌ Google Cloud SDK installation failed."
  exit 1
fi

