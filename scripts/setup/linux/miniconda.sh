#!/usr/bin/env bash
set -euo pipefail

# Directory where Miniconda will be installed
CONDA_DIR="$HOME/miniconda"
INSTALLER="/tmp/Miniconda3-latest-Linux-x86_64.sh"
USER_NAME=$(whoami)

# 1. Check if conda is already installed
if [ -x "$CONDA_DIR/bin/conda" ]; then
  echo "✅ Miniconda is already installed at $CONDA_DIR."
else
  echo "🔄 Installing Miniconda…"

  # 2. Download installer
  cd /tmp
  curl -fsSL -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
  chmod +x Miniconda3-latest-Linux-x86_64.sh

  # 3. Run installer in batch mode
  ./Miniconda3-latest-Linux-x86_64.sh -b -p "$CONDA_DIR"

  # 4. Fix permissions (in case script was run with sudo)
  chown -R "$USER_NAME":"$USER_NAME" "$CONDA_DIR"

  # 5. Initialize Conda for Zsh (and Bash if desired)
  #    You can add additional shells by changing the argument (e.g. 'bash')
  "$CONDA_DIR/bin/conda" init zsh

  # 6. Cleanup installer
  rm -f Miniconda3-latest-Linux-x86_64.sh

  echo "✅ Miniconda installed at $CONDA_DIR."
fi

echo "🎉 Setup complete! Restart your terminal or run 'source ~/.zshrc' to activate Conda."
