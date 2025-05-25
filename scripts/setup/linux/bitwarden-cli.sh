#!/usr/bin/env bash
set -euo pipefail

# Check if Bitwarden CLI is already installed
if command -v bw &>/dev/null; then
  echo "✅ Bitwarden CLI (bw) is already installed."
  exit 0
fi

echo "🔄 Installing Bitwarden CLI…"

# 1. Fetch latest release tag
BW_VERSION=$(curl -s https://api.github.com/repos/bitwarden/cli/releases/latest \
  | grep '"tag_name":' | cut -d'"' -f4)
echo "→ Latest version is $BW_VERSION"

# 2. Download and unzip
ZIP_NAME="bw-linux-${BW_VERSION#v}.zip"
curl -fsSL -o bw.zip "https://github.com/bitwarden/cli/releases/download/${BW_VERSION}/${ZIP_NAME}"
unzip -q bw.zip

# 3. Install binary
sudo mv bw /usr/local/bin/

# 4. Cleanup
rm -f bw.zip

echo "✅ Bitwarden CLI $BW_VERSION installation complete."