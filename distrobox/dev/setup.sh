#!/bin/bash
# Post-creation setup script for distrobox dev environment
# Run this after entering the container for the first time

set -e

echo "================================"
echo "Distrobox Dev Environment Setup"
echo "================================"
echo ""

# Install Python packages
echo "Installing Python packages..."
pip install --user --break-system-packages \
    python-frontmatter

# Install lazydocker
if ! command -v lazydocker &> /dev/null; then
    echo "Installing lazydocker..."
    curl -fsSL https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash || echo "lazydocker installation failed, skipping..."
fi

# Install Claude Code
if ! command -v claude &> /dev/null; then
    echo "Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | bash || echo "Claude Code installation failed, skipping..."
fi

# Install opencode
if ! command -v opencode &> /dev/null; then
    echo "Installing opencode..."
    curl -fsSL https://raw.githubusercontent.com/opencode-ai/opencode/refs/heads/main/install | bash || echo "opencode installation failed, skipping..."
fi

# Install Fabric
if ! command -v fabric &> /dev/null; then
    echo "Installing Fabric..."
    curl -fsSL https://raw.githubusercontent.com/danielmiessler/fabric/main/scripts/installer/install.sh | bash || echo "Fabric installation failed, skipping..."
fi

# Install JetBrainsMono Nerd Font
echo ""
echo "Setting up JetBrainsMono Nerd Font..."
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

if [ ! -f "$FONT_DIR/JetBrainsMonoNerdFont-Regular.ttf" ]; then
    cd /tmp
    wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
    unzip -o JetBrainsMono.zip -d JetBrainsMono
    cp JetBrainsMono/*.ttf "$FONT_DIR/"
    fc-cache -fv 2>/dev/null || true
    rm -rf JetBrainsMono JetBrainsMono.zip
    echo "JetBrainsMono Nerd Font installed"
else
    echo "JetBrainsMono Nerd Font already installed"
fi

# Setup LazyVim
echo ""
echo "Setting up LazyVim..."
if [ ! -d "$HOME/.config/nvim" ]; then
    git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
    rm -rf "$HOME/.config/nvim/.git"
    echo "LazyVim installed. Run 'nvim' to complete setup."
else
    echo "Neovim config already exists at ~/.config/nvim"
fi

# Initialize zoxide in shell configs
echo ""
echo "Configuring shell integrations..."
if ! grep -q "zoxide init" "$HOME/.zshrc" 2>/dev/null; then
    echo 'eval "$(zoxide init zsh)"' >> "$HOME/.zshrc"
fi
if ! grep -q "zoxide init" "$HOME/.bashrc" 2>/dev/null; then
    echo 'eval "$(zoxide init bash)"' >> "$HOME/.bashrc"
fi

# Setup Starship prompt
if ! grep -q "starship init" "$HOME/.zshrc" 2>/dev/null; then
    echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
fi
if ! grep -q "starship init" "$HOME/.bashrc" 2>/dev/null; then
    echo 'eval "$(starship init bash)"' >> "$HOME/.bashrc"
fi

echo ""
echo "================================"
echo "Setup Complete!"
echo "================================"
echo ""
echo "Next steps:"
echo "1. Run 'nvim' to complete LazyVim setup"
echo "2. Configure AI tools with API keys:"
echo "   - Claude Code: claude configure"
echo "   - Fabric: fabric --setup"
echo "3. Restart your shell or run: source ~/.bashrc"
echo ""
