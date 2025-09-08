#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "🔄 Setting hostname to india"
sudo hostnamectl set-hostname india
echo "✅ Hostname set to india"

if ! id -u budchris &>/dev/null; then
  echo "🔄 Creating admin user budchris"
  sudo useradd -m -G wheel budchris
  echo "→ Set password for budchris"
  sudo passwd budchris
  echo "✅ User budchris created"
else
  echo "✅ User budchris already exists"
fi

echo "🔄 Resetting Arch keyring"
sudo pacman-key --init
sudo pacman-key --populate
sudo pacman -Syy --noconfirm archlinux-keyring
echo "✅ Arch keyring reset"

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
