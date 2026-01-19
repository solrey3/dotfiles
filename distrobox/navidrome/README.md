# Distrobox Navidrome Environment

Arch Linux-based container for running Navidrome music server and managing music libraries.

## Quick Start

```bash
podman build -t distrobox-navidrome ~/.dotfiles/distrobox/navidrome/
distrobox create -i distrobox-navidrome -n navidrome
distrobox enter navidrome
distrobox-setup
```

## Included Tools

### Music Server
- **Navidrome** - Modern music server (Subsonic/Airsonic compatible)

### Audio Processing
| Tool | Description |
|------|-------------|
| ffmpeg | Audio/video converter |
| flac | FLAC encoder/decoder |
| lame | MP3 encoder |
| opus-tools | Opus encoder |
| vorbis-tools | Ogg Vorbis tools |

### Library Management
| Tool | Description |
|------|-------------|
| beets | Music library manager & tagger |
| mutagen | Python audio metadata library |
| pyacoustid | Audio fingerprinting |

## Directory Structure

```
~/.navidrome/
├── navidrome.toml    # Configuration
├── data/             # Database and cache
└── cache/            # Transcoding cache

~/Music/              # Your music library
```

## Helper Commands

| Command | Description |
|---------|-------------|
| `navidrome-start` | Start Navidrome server |
| `navidrome-scan` | Trigger library scan |
| `music-convert` | Convert audio formats |
| `music-tag` | View file metadata |

## Configuration

Edit `~/.navidrome/navidrome.toml`:

```toml
MusicFolder = '/home/deck/Music'
DataFolder = '/home/deck/.navidrome/data'
Port = 4533
Address = '0.0.0.0'

# Optional settings
ScanSchedule = '@every 1h'
TranscodingCacheSize = '150MB'
EnableGravatar = true
EnableStarRating = true
```

## Common Workflows

### Start Server

```bash
navidrome-start
# Open http://localhost:4533
# Create admin account on first visit
```

### Convert Audio

```bash
# FLAC to MP3
music-convert album.flac album.mp3 320k

# FLAC to Opus
music-convert track.flac track.opus 128k
```

### Batch Convert

```bash
# Convert all FLAC to MP3
for f in *.flac; do
    music-convert "$f" "${f%.flac}.mp3" 320k
done
```

### View/Edit Tags

```bash
# View tags
music-tag song.mp3

# Edit with beets
beet import ~/Music/new-album/
```

### Using Beets

```bash
# Initialize beets
beet config -e  # Edit config

# Import music
beet import ~/Music/

# List library
beet ls

# Search
beet ls artist:Beatles
```

## Subsonic Clients

Navidrome is compatible with Subsonic clients:

- **Desktop**: Submariner (macOS), Clementine
- **Mobile**: Symfonium (Android), play:Sub (iOS)
- **Web**: Substreamer, Airsonic Web

Connect using: `http://localhost:4533`

## Exposing to Network

To access from other devices:

```bash
# Navidrome binds to 0.0.0.0 by default
# Find your IP
ip addr show | grep inet

# Access from other devices
# http://YOUR_IP:4533
```

## Transcoding

Navidrome transcodes on-the-fly. Supported formats:
- Input: FLAC, MP3, OGG, OPUS, AAC, WMA, and more
- Output: MP3, OPUS (configured per client)
