#!/bin/bash
# Post-creation setup script for nginx distrobox
set -e

echo "===================================="
echo "Distrobox Nginx Environment Setup"
echo "===================================="
echo ""

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"
export PATH="$BIN_DIR:$PATH"

# Create nginx workspace
NGINX_WORKSPACE="$HOME/nginx-workspace"
mkdir -p "$NGINX_WORKSPACE"/{sites,ssl,logs,html}

# Create sample nginx configs
if [ ! -f "$NGINX_WORKSPACE/sites/default.conf" ]; then
    cat > "$NGINX_WORKSPACE/sites/default.conf" << 'EOF'
server {
    listen 8080;
    server_name localhost;
    root /home/deck/nginx-workspace/html;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
EOF
fi

if [ ! -f "$NGINX_WORKSPACE/html/index.html" ]; then
    cat > "$NGINX_WORKSPACE/html/index.html" << 'EOF'
<!DOCTYPE html>
<html>
<head><title>Nginx Test</title></head>
<body><h1>Nginx is working!</h1></body>
</html>
EOF
fi

# Create helper scripts
cat > "$BIN_DIR/nginx-test" << 'EOF'
#!/bin/bash
# Test nginx configuration
nginx -t -c "${1:-/etc/nginx/nginx.conf}"
EOF
chmod +x "$BIN_DIR/nginx-test"

cat > "$BIN_DIR/nginx-start" << 'EOF'
#!/bin/bash
# Start nginx with custom config
CONFIG="${1:-$HOME/nginx-workspace/sites/default.conf}"
echo "Starting nginx with config: $CONFIG"
nginx -c "$CONFIG" -p "$HOME/nginx-workspace" -g "daemon off; error_log $HOME/nginx-workspace/logs/error.log; pid $HOME/nginx-workspace/nginx.pid;"
EOF
chmod +x "$BIN_DIR/nginx-start"

cat > "$BIN_DIR/nginx-reload" << 'EOF'
#!/bin/bash
# Reload nginx configuration
nginx -s reload
EOF
chmod +x "$BIN_DIR/nginx-reload"

cat > "$BIN_DIR/ssl-gen" << 'EOF'
#!/bin/bash
# Generate self-signed SSL certificate
DOMAIN="${1:-localhost}"
SSL_DIR="$HOME/nginx-workspace/ssl"
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "$SSL_DIR/$DOMAIN.key" \
    -out "$SSL_DIR/$DOMAIN.crt" \
    -subj "/CN=$DOMAIN"
echo "Certificate generated: $SSL_DIR/$DOMAIN.crt"
EOF
chmod +x "$BIN_DIR/ssl-gen"

# Install hey (HTTP load generator)
if ! command -v hey &> /dev/null; then
    echo "Installing hey (HTTP load tester)..."
    HEY_VERSION=$(curl -fsSL "https://api.github.com/repos/rakyll/hey/releases/latest" | jq -r '.tag_name')
    curl -fsSLo "$BIN_DIR/hey" "https://hey-release.s3.us-east-2.amazonaws.com/hey_linux_amd64"
    chmod +x "$BIN_DIR/hey"
fi

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
echo "===================================="
echo "Setup Complete!"
echo "===================================="
echo ""
echo "Workspace created: ~/nginx-workspace/"
echo "  sites/  - nginx configuration files"
echo "  ssl/    - SSL certificates"
echo "  logs/   - log files"
echo "  html/   - static content"
echo ""
echo "Helper commands:"
echo "  nginx-test [config]  - Test nginx configuration"
echo "  nginx-start [config] - Start nginx (foreground)"
echo "  nginx-reload         - Reload configuration"
echo "  ssl-gen [domain]     - Generate self-signed cert"
echo ""
echo "Testing tools:"
echo "  curl, httpie, wrk, siege, hey"
echo ""
echo "Quick start:"
echo "  nginx-start   # Start with default config on :8080"
echo "  curl localhost:8080"
echo ""
