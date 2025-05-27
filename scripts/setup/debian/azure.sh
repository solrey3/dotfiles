#!/usr/bin/env bash
set -euo pipefail

# Script: setup-azure-cli.sh
# Works on Ubuntu, Debian, and Linux Mint.

# 1. Check if Azure CLI is already installed
if command -v az &>/dev/null; then
  echo "✅ Azure CLI is already installed: $(az --version 2>&1 | head -n1)"
  exit 0
else
  echo "🔄 Installing Azure CLI…"
fi

# 2. Determine the correct Ubuntu codename for Mint
AZ_REPO=$(grep UBUNTU_CODENAME /etc/os-release | cut -d= -f2)
if [ -z "$AZ_REPO" ]; then
  AZ_REPO=$(lsb_release -cs)
fi

# 3. Import Microsoft GPG key
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc |
  gpg --dearmor |
  sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg >/dev/null
sudo chmod 644 /etc/apt/trusted.gpg.d/microsoft.gpg

# 4. Add Azure CLI APT repository
echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/microsoft.gpg] \
https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
  sudo tee /etc/apt/sources.list.d/azure-cli.list >/dev/null

# 5. Update & install
sudo apt update
sudo apt install -y azure-cli

# 6. Verify installation
if command -v az &>/dev/null; then
  echo "✅ Azure CLI installation complete: $(az --version 2>&1 | head -n1)"
else
  echo "❌ Azure CLI installation failed."
  exit 1
fi

