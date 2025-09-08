#!/usr/bin/env bash
set -euo pipefail

echo "🔄 Configuring git"
command -v git &>/dev/null || {
  echo "git not installed"
  exit 1
}
git config --global user.email "solrey3@solrey3.com"
git config --global user.name "Solito Reyes III"
echo "✅ Git configured"
