#!/usr/bin/env bash
set -euo pipefail

ZSHRC="$HOME/.zshrc"
INIT_CMD='eval "$(starship init zsh)"'

# 1. Install Starship if missing
if command -v starship &>/dev/null; then
  echo "✅ Starship is already installed."
else
  echo "🔄 Installing Starship prompt…"
  curl -sS https://starship.rs/install.sh | sh -s -- -y
  echo "✅ Starship installed."
fi

# 2. Add init line to .zshrc if not present
if grep -Fxq "$INIT_CMD" "$ZSHRC"; then
  echo "✅ Starship init already present in $ZSHRC."
else
  echo "→ Adding Starship init to $ZSHRC…"
  echo "" >> "$ZSHRC"
  echo "# Initialize Starship prompt" >> "$ZSHRC"
  echo "$INIT_CMD" >> "$ZSHRC"
  echo "✅ Added Starship init to $ZSHRC."
fi

echo "🎉 Starship setup complete! Restart your terminal or run 'source ~/.zshrc' to start using it."