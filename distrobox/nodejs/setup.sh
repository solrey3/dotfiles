#!/bin/bash
# Post-creation setup script for Node.js/TypeScript distrobox
set -e

echo "==========================================="
echo "Distrobox Node.js/TypeScript Environment Setup"
echo "==========================================="
echo ""

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"
export PATH="$BIN_DIR:$PATH"

# Install Bun
if ! command -v bun &> /dev/null; then
    echo "Installing Bun..."
    curl -fsSL https://bun.sh/install | bash || echo "Bun installation failed, skipping..."
fi

# Install pnpm
if ! command -v pnpm &> /dev/null; then
    echo "Installing pnpm..."
    curl -fsSL https://get.pnpm.io/install.sh | sh - || echo "pnpm installation failed, skipping..."
fi

# Install fnm (Fast Node Manager) for version management
if ! command -v fnm &> /dev/null; then
    echo "Installing fnm (Node version manager)..."
    curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell || echo "fnm installation failed, skipping..."
fi

# Install global npm packages
echo ""
echo "Installing global npm packages..."
npm install -g \
    typescript \
    ts-node \
    tsx \
    @types/node \
    eslint \
    prettier \
    nodemon \
    pm2 \
    turbo \
    concurrently \
    npm-check-updates \
    serve \
    http-server \
    2>/dev/null || echo "Some npm packages failed, continuing..."

# Install TypeScript language server and tools
npm install -g \
    @typescript-eslint/parser \
    @typescript-eslint/eslint-plugin \
    typescript-language-server \
    vscode-langservers-extracted \
    2>/dev/null || echo "Some language servers failed, continuing..."

# Shell configuration
echo ""
echo "Configuring shell..."

# PATH
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc" 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.zshrc" 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
fi

# Bun
if [ -f "$HOME/.bun/bin/bun" ]; then
    if ! grep -q 'BUN_INSTALL' "$HOME/.bashrc" 2>/dev/null; then
        echo 'export BUN_INSTALL="$HOME/.bun"' >> "$HOME/.bashrc"
        echo 'export PATH="$BUN_INSTALL/bin:$PATH"' >> "$HOME/.bashrc"
    fi
    if ! grep -q 'BUN_INSTALL' "$HOME/.zshrc" 2>/dev/null; then
        echo 'export BUN_INSTALL="$HOME/.bun"' >> "$HOME/.zshrc"
        echo 'export PATH="$BUN_INSTALL/bin:$PATH"' >> "$HOME/.zshrc"
    fi
fi

# pnpm
if [ -d "$HOME/.local/share/pnpm" ]; then
    if ! grep -q 'PNPM_HOME' "$HOME/.bashrc" 2>/dev/null; then
        echo 'export PNPM_HOME="$HOME/.local/share/pnpm"' >> "$HOME/.bashrc"
        echo 'export PATH="$PNPM_HOME:$PATH"' >> "$HOME/.bashrc"
    fi
    if ! grep -q 'PNPM_HOME' "$HOME/.zshrc" 2>/dev/null; then
        echo 'export PNPM_HOME="$HOME/.local/share/pnpm"' >> "$HOME/.zshrc"
        echo 'export PATH="$PNPM_HOME:$PATH"' >> "$HOME/.zshrc"
    fi
fi

# fnm
if [ -d "$HOME/.local/share/fnm" ] || [ -d "$HOME/.fnm" ]; then
    if ! grep -q 'fnm env' "$HOME/.bashrc" 2>/dev/null; then
        echo 'eval "$(fnm env --use-on-cd)"' >> "$HOME/.bashrc"
    fi
    if ! grep -q 'fnm env' "$HOME/.zshrc" 2>/dev/null; then
        echo 'eval "$(fnm env --use-on-cd)"' >> "$HOME/.zshrc"
    fi
fi

# zoxide
if ! grep -q "zoxide init" "$HOME/.bashrc" 2>/dev/null; then
    echo 'eval "$(zoxide init bash)"' >> "$HOME/.bashrc"
fi
if ! grep -q "zoxide init" "$HOME/.zshrc" 2>/dev/null; then
    echo 'eval "$(zoxide init zsh)"' >> "$HOME/.zshrc"
fi

# starship
if ! grep -q "starship init" "$HOME/.bashrc" 2>/dev/null; then
    echo 'eval "$(starship init bash)"' >> "$HOME/.bashrc"
fi
if ! grep -q "starship init" "$HOME/.zshrc" 2>/dev/null; then
    echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
fi

echo ""
echo "==========================================="
echo "Setup Complete!"
echo "==========================================="
echo ""
echo "Package managers:"
echo "  npm   - Node Package Manager"
echo "  yarn  - Yarn Classic"
echo "  pnpm  - Performant npm"
echo "  bun   - All-in-one toolkit"
echo ""
echo "Node version management:"
echo "  fnm install 20    - Install Node 20"
echo "  fnm use 20        - Switch to Node 20"
echo "  fnm list          - List installed versions"
echo ""
echo "TypeScript tools:"
echo "  tsc       - TypeScript compiler"
echo "  ts-node   - Run TS directly"
echo "  tsx       - Fast TS execution"
echo ""
echo "Development tools:"
echo "  nodemon   - Auto-restart on changes"
echo "  pm2       - Process manager"
echo "  turbo     - Monorepo build system"
echo "  serve     - Static file server"
echo "  ncu       - Check for updates (npm-check-updates)"
echo ""
echo "Linting/Formatting:"
echo "  eslint    - JavaScript/TypeScript linter"
echo "  prettier  - Code formatter"
echo ""
echo "Quick start:"
echo "  mkdir my-app && cd my-app"
echo "  bun init           # or: npm init -y"
echo "  bun add typescript # or: npm i typescript"
echo ""
echo "Restart shell or: source ~/.bashrc"
echo ""
