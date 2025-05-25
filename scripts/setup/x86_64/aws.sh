#!/usr/bin/env bash
set -euo pipefail

# Script: setup-aws-cli.sh
# Installs AWS CLI v2 if not already installed.

# 1. Check if AWS CLI is already installed
if command -v aws &>/dev/null; then
  echo "✅ AWS CLI is already installed: $(aws --version)"
  exit 0
else
  echo "🔄 Installing AWS CLI v2…"
fi

# 2. Define temp paths
TMP_ZIP="/tmp/awscliv2.zip"
TMP_DIR="/tmp/aws"

# 3. Download the AWS CLI bundle
curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "$TMP_ZIP"

# 4. Unzip the installer
unzip -q "$TMP_ZIP" -d /tmp

# 5. Run the installer
sudo "$TMP_DIR/install" --update

# 6. Cleanup
rm -rf "$TMP_DIR" "$TMP_ZIP"

# 7. Verify installation
if command -v aws &>/dev/null; then
  echo "✅ AWS CLI installation complete: $(aws --version)"
else
  echo "❌ AWS CLI installation failed."
  exit 1
fi