#!/bin/bash
# Post-creation setup script for Navidrome distrobox
set -e

echo "======================================="
echo "Distrobox Navidrome Environment Setup"
echo "======================================="
echo ""

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"
export PATH="$BIN_DIR:$PATH"

# Create Navidrome directories
NAVIDROME_DIR="$HOME/.navidrome"
MUSIC_DIR="$HOME/Music"
mkdir -p "$NAVIDROME_DIR" "$MUSIC_DIR"

# Install Navidrome
if ! command -v navidrome &> /dev/null && [ ! -f "$BIN_DIR/navidrome" ]; then
    echo "Installing Navidrome..."
    NAVIDROME_VERSION=$(curl -fsSL "https://api.github.com/repos/navidrome/navidrome/releases/latest" | jq -r '.tag_name' | sed 's/v//')
    ARCH="amd64"
    [ "$(uname -m)" = "aarch64" ] && ARCH="arm64"
    curl -fsSLo /tmp/navidrome.tar.gz "https://github.com/navidrome/navidrome/releases/download/v${NAVIDROME_VERSION}/navidrome_${NAVIDROME_VERSION}_linux_${ARCH}.tar.gz"
    tar -xzf /tmp/navidrome.tar.gz -C "$BIN_DIR" navidrome
    chmod +x "$BIN_DIR/navidrome"
    rm /tmp/navidrome.tar.gz
    echo "Navidrome installed: v${NAVIDROME_VERSION}"
fi

# Create default config
if [ ! -f "$NAVIDROME_DIR/navidrome.toml" ]; then
    cat > "$NAVIDROME_DIR/navidrome.toml" << EOF
# Navidrome Configuration
MusicFolder = '$MUSIC_DIR'
DataFolder = '$NAVIDROME_DIR/data'
CacheFolder = '$NAVIDROME_DIR/cache'
LogLevel = 'info'
Address = '0.0.0.0'
Port = 4533
# ScanSchedule = '@every 1h'
# TranscodingCacheSize = '150MB'
EOF
    mkdir -p "$NAVIDROME_DIR/data" "$NAVIDROME_DIR/cache"
    echo "Config created: $NAVIDROME_DIR/navidrome.toml"
fi

# Install Python music tools
echo ""
echo "Installing Python music tools..."
pip install --user --break-system-packages \
    pyacoustid \
    mutagen \
    musicbrainzngs \
    2>/dev/null || echo "Some Python packages failed, continuing..."

# Create helper scripts
cat > "$BIN_DIR/navidrome-start" << 'EOF'
#!/bin/bash
CONFIG="${NAVIDROME_CONFIG:-$HOME/.navidrome/navidrome.toml}"
echo "Starting Navidrome..."
echo "Config: $CONFIG"
echo "Web UI: http://localhost:4533"
navidrome --configfile "$CONFIG"
EOF
chmod +x "$BIN_DIR/navidrome-start"

cat > "$BIN_DIR/navidrome-scan" << 'EOF'
#!/bin/bash
# Trigger a music library scan
curl -s "http://localhost:4533/api/scan" -X POST 2>/dev/null || echo "Navidrome not running or scan endpoint not available"
EOF
chmod +x "$BIN_DIR/navidrome-scan"

cat > "$BIN_DIR/music-convert" << 'EOF'
#!/bin/bash
# Convert audio files to different formats
# Usage: music-convert input.flac output.mp3 [bitrate]
INPUT="$1"
OUTPUT="$2"
BITRATE="${3:-320k}"

if [ -z "$INPUT" ] || [ -z "$OUTPUT" ]; then
    echo "Usage: music-convert input.flac output.mp3 [bitrate]"
    echo "Supported formats: mp3, flac, opus, ogg, m4a"
    exit 1
fi

ffmpeg -i "$INPUT" -b:a "$BITRATE" "$OUTPUT"
EOF
chmod +x "$BIN_DIR/music-convert"

cat > "$BIN_DIR/music-tag" << 'EOF'
#!/bin/bash
# View/edit music tags with mutagen
# Usage: music-tag file.mp3
python3 -c "
import sys
from mutagen import File

if len(sys.argv) < 2:
    print('Usage: music-tag file.mp3')
    sys.exit(1)

f = File(sys.argv[1], easy=True)
if f:
    for k, v in sorted(f.items()):
        print(f'{k}: {v}')
else:
    print('Could not read file')
" "$@"
EOF
chmod +x "$BIN_DIR/music-tag"

# Shell configuration
echo ""
echo "Configuring shell..."

if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc" 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.zshrc" 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
fi

if ! grep -q "zoxide init" "$HOME/.bashrc" 2>/dev/null; then
    echo 'eval "$(zoxide init bash)"' >> "$HOME/.bashrc"
fi
if ! grep -q "zoxide init" "$HOME/.zshrc" 2>/dev/null; then
    echo 'eval "$(zoxide init zsh)"' >> "$HOME/.zshrc"
fi

if ! grep -q "starship init" "$HOME/.bashrc" 2>/dev/null; then
    echo 'eval "$(starship init bash)"' >> "$HOME/.bashrc"
fi
if ! grep -q "starship init" "$HOME/.zshrc" 2>/dev/null; then
    echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
fi

echo ""
echo "======================================="
echo "Setup Complete!"
echo "======================================="
echo ""
echo "Navidrome directories:"
echo "  Config: ~/.navidrome/navidrome.toml"
echo "  Data:   ~/.navidrome/data/"
echo "  Music:  ~/Music/"
echo ""
echo "Helper commands:"
echo "  navidrome-start  - Start Navidrome server"
echo "  navidrome-scan   - Trigger library scan"
echo "  music-convert    - Convert audio formats"
echo "  music-tag        - View music file tags"
echo ""
echo "Audio tools:"
echo "  ffmpeg   - Audio/video converter"
echo "  beets    - Music library manager"
echo "  flac     - FLAC encoder/decoder"
echo "  lame     - MP3 encoder"
echo ""
echo "Quick start:"
echo "  1. Add music to ~/Music/"
echo "  2. Run: navidrome-start"
echo "  3. Open: http://localhost:4533"
echo "  4. Create admin account on first run"
echo ""
