#!/usr/bin/env bash
set -euo pipefail

# Root of your repo
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ————————————————————————————————
# List your scripts here in the exact order you want them to run:
# ————————————————————————————————
SCRIPTS=(
  # ---------- Ubuntu‐LTS Core & CLI tools ----------
  "$ROOT_DIR/setup/ubuntu-lts/apt.sh"
  "$ROOT_DIR/setup/debian/jetbrainsmono-nerd-font.sh"
  "$ROOT_DIR/setup/debian/zsh.sh"
  "$ROOT_DIR/setup/linux/starship.sh"
  "$ROOT_DIR/setup/debian/fastfetch.sh"
  "$ROOT_DIR/setup/linux/cargo.sh"
  "$ROOT_DIR/setup/linux/neovim.sh"
  "$ROOT_DIR/setup/linux/x86_64/fabric-ai.sh"
  "$ROOT_DIR/setup/linux/yt-dlp.sh"

  # ---------- DevOps Helpers ----------
  "$ROOT_DIR/setup/debian/devops.sh"
  "$ROOT_DIR/setup/linux/helm.sh"
  "$ROOT_DIR/setup/linux/k9s.sh"
  "$ROOT_DIR/setup/linux/lazygit.sh"
  "$ROOT_DIR/setup/debian/gcloud.sh"
  "$ROOT_DIR/setup/debian/azure.sh"
  "$ROOT_DIR/setup/linux/x86_64/aws.sh"
  "$ROOT_DIR/setup/debian/1password-cli.sh"
  "$ROOT_DIR/setup/linux/bitwarden-cli.sh"

  # ---------- Language / Env / Editor ----------
  "$ROOT_DIR/setup/debian/typescript.sh"
  "$ROOT_DIR/setup/linux/miniconda.sh"

  # ---------- Services ----------
  # "$ROOT_DIR/setup/debian/avahi.sh"
  # "$ROOT_DIR/setup/ubuntu-lts/docker.sh"
  # "$ROOT_DIR/setup/debian/jellyfin.sh"
  # "$ROOT_DIR/setup/linux/ollama.sh"

  # ---------- Desktop Environment ----------
  # "$ROOT_DIR/setup/debian/xfce-i3.sh"
  # "$ROOT_DIR/setup/ubuntu-lts/ghostty.sh"
  # "$ROOT_DIR/setup/linux/alacritty.sh"
  # "$ROOT_DIR/setup/debian/wezterm.sh"
  # "$ROOT_DIR/setup/linux/brave.sh"

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

# Finally, run your stow‐based dotfiles
echo "🔧 Applying dotfiles with stow…"
bash "$ROOT_DIR/stow/dotfiles.sh"

echo "✅ All setup steps complete!"
