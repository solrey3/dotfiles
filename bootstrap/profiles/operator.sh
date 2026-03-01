#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# bootstrap/profiles/operator.sh — Cloud + K8s + DB Operator Profile
# Extends base ubuntu-server.sh with DevOps/cloud tooling
# Target: lab.solr.net (Simplenight DevOps command center)
# =============================================================================

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../.."

echo "🛠️  Starting operator profile bootstrap..."

# Run base first
bash "$(dirname "$0")/../ubuntu-server.sh"

SCRIPTS=(
  # Cloud CLIs
  "$ROOT_DIR/scripts/setup/debian/gcloud.sh"
  "$ROOT_DIR/scripts/setup/debian/azure.sh"
  "$ROOT_DIR/scripts/setup/linux/x86_64/aws.sh"

  # Kubernetes
  "$ROOT_DIR/scripts/setup/linux/helm.sh"
  "$ROOT_DIR/scripts/setup/linux/k9s.sh"

  # Database clients
  # (postgres, redis — installed via apt in apt.sh)

  # Secrets
  "$ROOT_DIR/scripts/setup/debian/1password-cli.sh"

  # AI coding
  "$ROOT_DIR/scripts/setup/linux/opencode-ai.sh"

  # Cloudflare / GH CLI
  # gh CLI included in apt.sh
)

for script in "${SCRIPTS[@]}"; do
  if [ ! -f "$script" ]; then
    echo "⚠️  SKIPPING missing script: $script"
    continue
  fi
  echo "▶ Running: $script"
  bash "$script"
done

echo "✅ Operator profile bootstrap complete!"
echo "   Next: stow your dotfiles and configure cloud auth (gcloud auth login, az login, aws configure)"
