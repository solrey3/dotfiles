#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# bootstrap/profiles/nanobot.sh — Nanobot AI Daemon Profile
# Extends base ubuntu-server.sh with Python, nanobot daemon, Telegram gateway
# Target: nanobot DO droplet (Personal AI assistant)
# =============================================================================

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../.."

echo "🤖 Starting nanobot profile bootstrap..."

# Run base first
bash "$(dirname "$0")/../ubuntu-server.sh"

SCRIPTS=(
  # Python runtime (via mise)
  # "$ROOT_DIR/scripts/setup/linux/mise.sh"

  # AI tooling
  "$ROOT_DIR/scripts/setup/linux/x86_64/fabric-ai.sh"
  "$ROOT_DIR/scripts/setup/linux/yt-dlp.sh"
)

for script in "${SCRIPTS[@]}"; do
  if [ ! -f "$script" ]; then
    echo "⚠️  SKIPPING missing script: $script"
    continue
  fi
  echo "▶ Running: $script"
  bash "$script"
done

# Install nanobot via pip
echo "▶ Installing nanobot..."
pip install --upgrade nanobot 2>/dev/null || pip3 install --upgrade nanobot

# Enable nanobot systemd service
echo "▶ Setting up nanobot systemd service..."
if [ -f "$ROOT_DIR/scripts/setup/linux/nanobot-service.sh" ]; then
  bash "$ROOT_DIR/scripts/setup/linux/nanobot-service.sh"
else
  echo "⚠️  nanobot-service.sh not found — configure systemd manually"
  echo "   Entry command: nanobot gateway"
fi

echo "✅ Nanobot profile bootstrap complete!"
echo "   Next: configure .env with API keys and run: nanobot gateway"
