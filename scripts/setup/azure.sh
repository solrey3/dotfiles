#!/usr/bin/env bash
set -euo pipefail

# Script: setup-azure-cli.sh
# Installs Azure CLI if not already present.

# 1. Check if Azure CLI is already installed
if command -v az &>/dev/null; then
  echo "✅ Azure CLI is already installed: $(az --version 2>&1 | head -n1)"
  exit 0
else
  echo "🔄 Installing Azure CLI…"
fi

# 2. Import Microsoft GPG key
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
  | gpg --dearmor \
  | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg >/dev/null

# 3. Add the Azure CLI apt repository
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" \
  | sudo tee /etc/apt/sources.list.d/azure-cli.list >/dev/null

# 4. Update & install
sudo apt update
sudo apt install -y azure-cli

# 5. Verify installation
if command -v az &>/dev/null; then
  echo "✅ Azure CLI installation complete: $(az --version 2>&1 | head -n1)"
else
  echo "❌ Azure CLI installation failed."
  exit 1
fi