#!/usr/bin/env bash
set -euo pipefail

# Directory and binary paths
BIN_DIR="$HOME/.local/bin"
BIN_PATH="$BIN_DIR/yt-dlp"
TMP_PATH="/tmp/yt-dlp.tmp"

# 1. Check if yt-dlp is already installed in ~/.local/bin
if [ -x "$BIN_PATH" ]; then
  echo "✅ yt-dlp is already installed at $BIN_PATH ($(yt-dlp --version))."
  exit 0
fi

# 2. Create target directory
echo "→ Creating $BIN_DIR (if needed)…"
mkdir -p "$BIN_DIR"

# 3. Download the latest release
echo "→ Downloading yt-dlp…"
curl -fsSL \
  "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp" \
  -o "$TMP_PATH"

# 4. Make it executable
chmod a+rx "$TMP_PATH"

# 5. Move into place
mv "$TMP_PATH" "$BIN_PATH"
echo "✅ yt-dlp installed to $BIN_PATH."

# 6. Verify
echo "→ Verifying installation…"
"$BIN_PATH" --version && echo "🎉 Setup complete!"
