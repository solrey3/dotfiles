#!/usr/bin/env bash
set -euo pipefail

# k9s
if command -v k9s &>/dev/null; then
  echo "✅ k9s is already installed."
else
  echo "🔄 Installing k9s…"
  K9S_TGZ="k9s_Linux_amd64.tar.gz"
  curl -sL -o "$K9S_TGZ" https://github.com/derailed/k9s/releases/latest/download/$K9S_TGZ
  tar -xzf "$K9S_TGZ"
  sudo mv k9s /usr/local/bin/
  rm -f "$K9S_TGZ"
  echo "✅ k9s installed."
fi
