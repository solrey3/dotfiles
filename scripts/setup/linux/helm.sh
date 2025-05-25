#!/usr/bin/env bash
set -euo pipefail

# Script: helm.sh
# Installs Helm if not already present.

# Helm
if command -v helm &>/dev/null; then
  echo "✅ Helm is already installed."
else
  echo "🔄 Installing Helm…"
  curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
  echo "✅ Helm installed (version $(helm version --short))."
fi
