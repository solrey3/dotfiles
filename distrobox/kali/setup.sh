#!/bin/bash
# Post-creation setup script for Kali Linux distrobox
# Run this after entering the container for the first time

set -e

echo "======================================="
echo "Distrobox Kali Linux Environment Setup"
echo "======================================="
echo ""

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"
export PATH="$BIN_DIR:$PATH"

# Install starship prompt
if ! command -v starship &> /dev/null; then
    echo "Installing Starship prompt..."
    curl -fsSL https://starship.rs/install.sh | sh -s -- -y -b "$BIN_DIR" || echo "Starship installation failed, skipping..."
fi

# Install zoxide
if ! command -v zoxide &> /dev/null; then
    echo "Installing zoxide..."
    curl -fsSL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash || echo "zoxide installation failed, skipping..."
fi

# Install eza (modern ls)
if ! command -v eza &> /dev/null; then
    echo "Installing eza..."
    EZA_VERSION=$(curl -fsSL "https://api.github.com/repos/eza-community/eza/releases/latest" | jq -r '.tag_name' | sed 's/v//')
    ARCH="x86_64"
    [ "$(uname -m)" = "aarch64" ] && ARCH="aarch64"
    curl -fsSLo /tmp/eza.tar.gz "https://github.com/eza-community/eza/releases/download/v${EZA_VERSION}/eza_${ARCH}-unknown-linux-gnu.tar.gz"
    tar -xzf /tmp/eza.tar.gz -C "$BIN_DIR"
    chmod +x "$BIN_DIR/eza"
    rm /tmp/eza.tar.gz
fi

# Install additional Python security tools
echo ""
echo "Installing additional Python tools..."
pip3 install --user --break-system-packages \
    pwntools \
    impacket \
    bloodhound \
    crackmapexec \
    pypykatz \
     2>/dev/null || echo "Some Python tools failed to install, continuing..."

echo ""
echo "Configuring shell..."

# Ensure ~/.local/bin is in PATH
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc" 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.zshrc" 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
fi

# Initialize zoxide
if command -v zoxide &> /dev/null; then
    if ! grep -q "zoxide init" "$HOME/.zshrc" 2>/dev/null; then
        echo 'eval "$(zoxide init zsh)"' >> "$HOME/.zshrc"
    fi
    if ! grep -q "zoxide init" "$HOME/.bashrc" 2>/dev/null; then
        echo 'eval "$(zoxide init bash)"' >> "$HOME/.bashrc"
    fi
fi

# Setup Starship prompt
if command -v starship &> /dev/null; then
    if ! grep -q "starship init" "$HOME/.zshrc" 2>/dev/null; then
        echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
    fi
    if ! grep -q "starship init" "$HOME/.bashrc" 2>/dev/null; then
        echo 'eval "$(starship init bash)"' >> "$HOME/.bashrc"
    fi
fi

# Useful aliases for pentesting
if ! grep -q "# Kali aliases" "$HOME/.bashrc" 2>/dev/null; then
    cat >> "$HOME/.bashrc" << 'EOF'

# Kali aliases
alias ll='ls -la'
alias serve='python3 -m http.server 8080'
alias myip='curl -s ifconfig.me'
alias listening='ss -tlnp'
alias connections='ss -tnp'
EOF
fi

echo ""
echo "======================================="
echo "Setup Complete!"
echo "======================================="
echo ""
echo "Kali Linux headless tools are installed."
echo ""
echo "Key tools available:"
echo ""
echo "  RECON & ENUMERATION"
echo "    nmap, masscan, nikto, dirb, gobuster"
echo "    whatweb, wafw00f, dnsrecon, dnsenum"
echo "    enum4linux, smbclient, nbtscan"
echo ""
echo "  WEB TESTING"
echo "    sqlmap, wpscan, commix, skipfish"
echo "    ffuf, feroxbuster, hydra"
echo ""
echo "  EXPLOITATION"
echo "    metasploit-framework (msfconsole)"
echo "    searchsploit, exploitdb"
echo ""
echo "  PASSWORD ATTACKS"
echo "    john, hashcat, hydra, medusa"
echo "    cewl, crunch, hash-identifier"
echo ""
echo "  WIRELESS"
echo "    aircrack-ng, reaver, wifite"
echo ""
echo "  POST-EXPLOITATION"
echo "    mimikatz, crackmapexec, impacket"
echo "    bloodhound, pypykatz, pwntools"
echo ""
echo "  FORENSICS & REVERSE"
echo "    binwalk, foremost, volatility"
echo "    radare2, gdb"
echo ""
echo "Quick start:"
echo "  msfconsole         - Start Metasploit"
echo "  searchsploit <term> - Search exploit-db"
echo "  nmap -sC -sV <ip>  - Standard service scan"
echo ""
echo "Restart shell or: source ~/.bashrc"
echo ""
