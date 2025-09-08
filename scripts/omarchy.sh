#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

SCRIPTS=(
  "$ROOT_DIR/setup/arch/pacman-core.sh"
  "$ROOT_DIR/setup/arch/yay.sh"
  "$ROOT_DIR/setup/arch/aur-packages.sh"
  "$ROOT_DIR/setup/linux/ssh-key.sh"
  "$ROOT_DIR/setup/linux/git.sh"
  "$ROOT_DIR/setup/linux/neovim.sh"
  "$ROOT_DIR/setup/linux/lazyvim.sh"
  "$ROOT_DIR/setup/linux/opencode-ai.sh"
)

echo "🔧 Running setup scripts in specified order…"
for script in "${SCRIPTS[@]}"; do
  if [ ! -f "$script" ]; then
    echo "⚠️  SKIPPING missing script: $script"
    continue
  fi
  echo "→ $script"
  chmod +x "$script"
  bash "$script"
done

echo "✅ All setup steps complete!"
