#!/bin/bash
# Post-creation setup script for GitHub Pages distrobox
set -e

echo "========================================="
echo "Distrobox GitHub Pages Environment Setup"
echo "========================================="
echo ""

BIN_DIR="$HOME/.local/bin"
GEM_DIR="$HOME/.gem/ruby/3.0.0/bin"
mkdir -p "$BIN_DIR"
export PATH="$BIN_DIR:$GEM_DIR:$PATH"

# Configure gem to install to user directory
if ! grep -q 'GEM_HOME' "$HOME/.bashrc" 2>/dev/null; then
    echo 'export GEM_HOME="$HOME/.gem"' >> "$HOME/.bashrc"
    echo 'export PATH="$HOME/.gem/ruby/3.0.0/bin:$PATH"' >> "$HOME/.bashrc"
fi
if ! grep -q 'GEM_HOME' "$HOME/.zshrc" 2>/dev/null; then
    echo 'export GEM_HOME="$HOME/.gem"' >> "$HOME/.zshrc"
    echo 'export PATH="$HOME/.gem/ruby/3.0.0/bin:$PATH"' >> "$HOME/.zshrc"
fi

export GEM_HOME="$HOME/.gem"

# Install Jekyll and GitHub Pages gem
echo "Installing Jekyll and GitHub Pages gems..."
gem install --user-install \
    jekyll \
    github-pages \
    jekyll-sitemap \
    jekyll-feed \
    jekyll-seo-tag \
    webrick \
    2>/dev/null || echo "Some gems failed, continuing..."

# Install Hugo (static site generator alternative)
if ! command -v hugo &> /dev/null; then
    echo "Installing Hugo..."
    HUGO_VERSION=$(curl -fsSL "https://api.github.com/repos/gohugoio/hugo/releases/latest" | jq -r '.tag_name' | sed 's/v//')
    ARCH="amd64"
    [ "$(uname -m)" = "aarch64" ] && ARCH="arm64"
    curl -fsSLo /tmp/hugo.tar.gz "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-${ARCH}.tar.gz"
    tar -xzf /tmp/hugo.tar.gz -C "$BIN_DIR" hugo
    chmod +x "$BIN_DIR/hugo"
    rm /tmp/hugo.tar.gz
fi

# Create helper scripts
cat > "$BIN_DIR/jekyll-new" << 'EOF'
#!/bin/bash
# Create new Jekyll site
NAME="${1:-my-site}"
jekyll new "$NAME"
cd "$NAME"
echo "Site created! Run: cd $NAME && jekyll-serve"
EOF
chmod +x "$BIN_DIR/jekyll-new"

cat > "$BIN_DIR/jekyll-serve" << 'EOF'
#!/bin/bash
# Serve Jekyll site with live reload
bundle exec jekyll serve --livereload --host 0.0.0.0 --port 4000 "$@"
EOF
chmod +x "$BIN_DIR/jekyll-serve"

cat > "$BIN_DIR/jekyll-build" << 'EOF'
#!/bin/bash
# Build Jekyll site for production
JEKYLL_ENV=production bundle exec jekyll build "$@"
EOF
chmod +x "$BIN_DIR/jekyll-build"

cat > "$BIN_DIR/gh-pages-deploy" << 'EOF'
#!/bin/bash
# Deploy to GitHub Pages (assumes gh-pages branch workflow)
set -e
jekyll-build
echo "Build complete! Push to deploy:"
echo "  git add . && git commit -m 'Update site' && git push"
EOF
chmod +x "$BIN_DIR/gh-pages-deploy"

# Shell configuration
echo ""
echo "Configuring shell..."

if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc" 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.zshrc" 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
fi

if ! grep -q "zoxide init" "$HOME/.bashrc" 2>/dev/null; then
    echo 'eval "$(zoxide init bash)"' >> "$HOME/.bashrc"
fi
if ! grep -q "zoxide init" "$HOME/.zshrc" 2>/dev/null; then
    echo 'eval "$(zoxide init zsh)"' >> "$HOME/.zshrc"
fi

if ! grep -q "starship init" "$HOME/.bashrc" 2>/dev/null; then
    echo 'eval "$(starship init bash)"' >> "$HOME/.bashrc"
fi
if ! grep -q "starship init" "$HOME/.zshrc" 2>/dev/null; then
    echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
fi

echo ""
echo "========================================="
echo "Setup Complete!"
echo "========================================="
echo ""
echo "Static site generators:"
echo "  jekyll  - Ruby-based (GitHub Pages native)"
echo "  hugo    - Go-based (fast builds)"
echo ""
echo "Helper commands:"
echo "  jekyll-new [name]   - Create new Jekyll site"
echo "  jekyll-serve        - Serve with live reload (:4000)"
echo "  jekyll-build        - Production build"
echo "  gh-pages-deploy     - Build for deployment"
echo ""
echo "Quick start (Jekyll):"
echo "  jekyll-new my-blog"
echo "  cd my-blog"
echo "  jekyll-serve"
echo ""
echo "Quick start (Hugo):"
echo "  hugo new site my-blog"
echo "  cd my-blog"
echo "  hugo server -D"
echo ""
echo "Image optimization:"
echo "  optipng image.png"
echo "  jpegoptim image.jpg"
echo ""
echo "Restart shell or: source ~/.bashrc"
echo ""
