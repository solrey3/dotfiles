#!/usr/bin/env bash
set -euo pipefail

# Desired plugins and their repo URLs
declare -A plugins=(
  [zsh-syntax-highlighting]=https://github.com/zsh-users/zsh-syntax-highlighting.git
  [fast-syntax-highlighting]=https://github.com/zdharma-continuum/fast-syntax-highlighting.git
  [zsh-autocomplete]=https://github.com/marlonrichert/zsh-autocomplete.git
)

# 1. Install Zsh if missing
if dpkg -s zsh &>/dev/null; then
  echo "✅ zsh is already installed."
else
  echo "🔄 Installing zsh…"
  sudo apt update
  sudo apt install -y zsh
fi

# 2. Install Oh My Zsh if missing (non-interactive)
if [ -d "${HOME}/.oh-my-zsh" ]; then
  echo "✅ Oh My Zsh is already installed."
else
  echo "🔄 Installing Oh My Zsh…"
  # Prevent the installer from changing shell or starting zsh immediately
  export RUNZSH=no
  export CHSH=no
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# 3. Install plugins
ZSH_CUSTOM=${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}
for name in "${!plugins[@]}"; do
  dest="${ZSH_CUSTOM}/plugins/${name}"
  if [ -d "$dest" ]; then
    echo "✅ Plugin '$name' already installed."
  else
    echo "🔄 Installing plugin '$name'…"
    git clone --depth=1 "${plugins[$name]}" "$dest"
  fi
done

# 4. Ensure .zshrc lists the plugins
rc="${HOME}/.zshrc"
if grep -q "zsh-syntax-highlighting" "$rc"; then
  echo "✅ .zshrc already configured with plugins."
else
  echo "🔄 Adding plugins to .zshrc…"
  # Insert plugins into the plugins=(...) line
  sed -i 's/^plugins=(\([^)]*\))/plugins=(\1 zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)/' "$rc"
fi

# 5. Make Zsh the default shell if not already
current_shell=$(getent passwd "$USER" | cut -d: -f7)
zsh_path=$(which zsh)
if [ "$current_shell" = "$zsh_path" ]; then
  echo "✅ Default shell is already Zsh."
else
  echo "🔄 Changing default shell to Zsh…"
  sudo chsh -s "$zsh_path" "$USER"
  echo "✅ Default shell changed. Logout and back in for effect."
fi

echo "🎉 Zsh + Oh My Zsh setup complete."
