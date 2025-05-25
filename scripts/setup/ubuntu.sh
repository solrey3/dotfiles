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
  "$ROOT_DIR/setup/ubuntu-lts/avahi.sh"
  "$ROOT_DIR/setup/ubuntu-lts/zsh.sh"
  "$ROOT_DIR/setup/ubuntu-lts/docker.sh"
  "$ROOT_DIR/setup/ubuntu-lts/gcloud.sh"
  "$ROOT_DIR/setup/ubuntu-lts/azure.sh"
  "$ROOT_DIR/setup/ubuntu-lts/devops.sh"
  "$ROOT_DIR/setup/ubuntu-lts/fastfetch.sh"
  "$ROOT_DIR/setup/ubuntu-lts/jellyfin.sh"
  "$ROOT_DIR/setup/ubuntu-lts/jetbrainsmono-nerd-font.sh"
  "$ROOT_DIR/setup/ubuntu-lts/typescript.sh"
  "$ROOT_DIR/setup/ubuntu-lts/yt-dlp.sh"
  "$ROOT_DIR/setup/ubuntu-lts/1password-cli.sh"

  # ---------- Language / Env / Editor ----------
  "$ROOT_DIR/setup/linux/cargo.sh"
  "$ROOT_DIR/setup/linux/alacritty.sh"
  "$ROOT_DIR/setup/linux/miniconda.sh"
  "$ROOT_DIR/setup/linux/neovim.sh"
  "$ROOT_DIR/setup/linux/starship.sh"

  # ---------- User & Productivity CLI’s ----------
  "$ROOT_DIR/setup/linux/bitwarden-cli.sh"
  "$ROOT_DIR/setup/linux/brave.sh"
  "$ROOT_DIR/setup/linux/ollama.sh"

  # ---------- DevOps Helpers ----------
  "$ROOT_DIR/setup/linux/helm.sh"
  "$ROOT_DIR/setup/linux/k9s.sh"
  "$ROOT_DIR/setup/linux/lazygit.sh"

  # ---------- Architecture‐specific ----------
  "$ROOT_DIR/setup/x86_64/aws.sh"
  "$ROOT_DIR/setup/x86_64/fabric-ai.sh"
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