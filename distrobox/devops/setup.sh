#!/bin/bash
# Post-creation setup script for distrobox devops environment
# Run this after entering the container for the first time

set -e

echo "====================================="
echo "Distrobox DevOps Environment Setup"
echo "====================================="
echo ""

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

# Ensure ~/.local/bin is in PATH for this session
export PATH="$BIN_DIR:$PATH"

# Helper function to get latest GitHub release
get_latest_release() {
    curl -fsSL "https://api.github.com/repos/$1/releases/latest" | jq -r '.tag_name'
}

# Google Cloud CLI
if ! command -v gcloud &> /dev/null; then
    echo "Installing Google Cloud CLI..."
    curl -fsSL https://sdk.cloud.google.com | bash -s -- --disable-prompts --install-dir="$HOME" || echo "GCP CLI installation failed, skipping..."
    if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then
        echo 'source "$HOME/google-cloud-sdk/path.bash.inc"' >> "$HOME/.bashrc"
        echo 'source "$HOME/google-cloud-sdk/path.zsh.inc"' >> "$HOME/.zshrc"
    fi
fi

# 1Password CLI
if ! command -v op &> /dev/null; then
    echo "Installing 1Password CLI..."
    OP_VERSION=$(get_latest_release "1Password/connect" | sed 's/v//')
    OP_ARCH="amd64"
    [ "$(uname -m)" = "aarch64" ] && OP_ARCH="arm64"
    curl -fsSLo /tmp/op.zip "https://cache.agilebits.com/dist/1P/op2/pkg/v${OP_VERSION}/op_linux_${OP_ARCH}_v${OP_VERSION}.zip" || \
    curl -fsSLo /tmp/op.zip "https://cache.agilebits.com/dist/1P/op2/pkg/latest/op_linux_${OP_ARCH}_latest.zip"
    unzip -o /tmp/op.zip -d /tmp/op
    mv /tmp/op/op "$BIN_DIR/"
    chmod +x "$BIN_DIR/op"
    rm -rf /tmp/op /tmp/op.zip
    echo "1Password CLI installed"
fi

echo ""
echo "Installing DevSecOps tools..."

# tfsec - Terraform security scanner
if ! command -v tfsec &> /dev/null; then
    echo "Installing tfsec..."
    TFSEC_VERSION=$(get_latest_release "aquasecurity/tfsec")
    ARCH="amd64"
    [ "$(uname -m)" = "aarch64" ] && ARCH="arm64"
    curl -fsSLo "$BIN_DIR/tfsec" "https://github.com/aquasecurity/tfsec/releases/download/${TFSEC_VERSION}/tfsec-linux-${ARCH}"
    chmod +x "$BIN_DIR/tfsec"
fi

# checkov - IaC security scanner
if ! command -v checkov &> /dev/null; then
    echo "Installing checkov..."
    pip install --user --break-system-packages checkov || echo "checkov installation failed, skipping..."
fi

# grype - Vulnerability scanner
if ! command -v grype &> /dev/null; then
    echo "Installing grype..."
    curl -fsSL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b "$BIN_DIR" || echo "grype installation failed, skipping..."
fi

# syft - SBOM generator
if ! command -v syft &> /dev/null; then
    echo "Installing syft..."
    curl -fsSL https://raw.githubusercontent.com/anchore/syft/main/install.sh | sh -s -- -b "$BIN_DIR" || echo "syft installation failed, skipping..."
fi

# hadolint - Dockerfile linter
if ! command -v hadolint &> /dev/null; then
    echo "Installing hadolint..."
    HADOLINT_VERSION=$(get_latest_release "hadolint/hadolint")
    ARCH="x86_64"
    [ "$(uname -m)" = "aarch64" ] && ARCH="arm64"
    curl -fsSLo "$BIN_DIR/hadolint" "https://github.com/hadolint/hadolint/releases/download/${HADOLINT_VERSION}/hadolint-Linux-${ARCH}"
    chmod +x "$BIN_DIR/hadolint"
fi

# kubesec - Kubernetes security scanner
if ! command -v kubesec &> /dev/null; then
    echo "Installing kubesec..."
    KUBESEC_VERSION=$(get_latest_release "controlplaneio/kubesec" | sed 's/v//')
    ARCH="amd64"
    [ "$(uname -m)" = "aarch64" ] && ARCH="arm64"
    curl -fsSLo /tmp/kubesec.tar.gz "https://github.com/controlplaneio/kubesec/releases/download/v${KUBESEC_VERSION}/kubesec_linux_${ARCH}.tar.gz"
    tar -xzf /tmp/kubesec.tar.gz -C "$BIN_DIR" kubesec
    chmod +x "$BIN_DIR/kubesec"
    rm /tmp/kubesec.tar.gz
fi

# kube-linter - Kubernetes manifest linter
if ! command -v kube-linter &> /dev/null; then
    echo "Installing kube-linter..."
    KUBELINTER_VERSION=$(get_latest_release "stackrox/kube-linter")
    ARCH="amd64"
    [ "$(uname -m)" = "aarch64" ] && ARCH="arm64"
    curl -fsSLo /tmp/kube-linter.tar.gz "https://github.com/stackrox/kube-linter/releases/download/${KUBELINTER_VERSION}/kube-linter-linux.tar.gz"
    tar -xzf /tmp/kube-linter.tar.gz -C "$BIN_DIR"
    chmod +x "$BIN_DIR/kube-linter"
    rm /tmp/kube-linter.tar.gz
fi

# terrascan - IaC security scanner
if ! command -v terrascan &> /dev/null; then
    echo "Installing terrascan..."
    TERRASCAN_VERSION=$(get_latest_release "tenable/terrascan" | sed 's/v//')
    ARCH="x86_64"
    [ "$(uname -m)" = "aarch64" ] && ARCH="arm64"
    curl -fsSLo /tmp/terrascan.tar.gz "https://github.com/tenable/terrascan/releases/download/v${TERRASCAN_VERSION}/terrascan_${TERRASCAN_VERSION}_Linux_${ARCH}.tar.gz"
    tar -xzf /tmp/terrascan.tar.gz -C "$BIN_DIR" terrascan
    chmod +x "$BIN_DIR/terrascan"
    rm /tmp/terrascan.tar.gz
fi

# gitleaks - Secret scanning
if ! command -v gitleaks &> /dev/null; then
    echo "Installing gitleaks..."
    GITLEAKS_VERSION=$(get_latest_release "gitleaks/gitleaks" | sed 's/v//')
    ARCH="x64"
    [ "$(uname -m)" = "aarch64" ] && ARCH="arm64"
    curl -fsSLo /tmp/gitleaks.tar.gz "https://github.com/gitleaks/gitleaks/releases/download/v${GITLEAKS_VERSION}/gitleaks_${GITLEAKS_VERSION}_linux_${ARCH}.tar.gz"
    tar -xzf /tmp/gitleaks.tar.gz -C "$BIN_DIR" gitleaks
    chmod +x "$BIN_DIR/gitleaks"
    rm /tmp/gitleaks.tar.gz
fi

# trufflehog - Secret scanning
if ! command -v trufflehog &> /dev/null; then
    echo "Installing trufflehog..."
    TRUFFLEHOG_VERSION=$(get_latest_release "trufflesecurity/trufflehog" | sed 's/v//')
    ARCH="amd64"
    [ "$(uname -m)" = "aarch64" ] && ARCH="arm64"
    curl -fsSLo /tmp/trufflehog.tar.gz "https://github.com/trufflesecurity/trufflehog/releases/download/v${TRUFFLEHOG_VERSION}/trufflehog_${TRUFFLEHOG_VERSION}_linux_${ARCH}.tar.gz"
    tar -xzf /tmp/trufflehog.tar.gz -C "$BIN_DIR" trufflehog
    chmod +x "$BIN_DIR/trufflehog"
    rm /tmp/trufflehog.tar.gz
fi

echo ""
echo "Configuring shell integrations..."

# Ensure ~/.local/bin is in PATH
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc" 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.zshrc" 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
fi

# Initialize zoxide
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

# kubectl completion
if ! grep -q "kubectl completion" "$HOME/.bashrc" 2>/dev/null; then
    echo 'source <(kubectl completion bash)' >> "$HOME/.bashrc"
    echo 'alias k=kubectl' >> "$HOME/.bashrc"
    echo 'complete -o default -F __start_kubectl k' >> "$HOME/.bashrc"
fi
if ! grep -q "kubectl completion" "$HOME/.zshrc" 2>/dev/null; then
    echo 'source <(kubectl completion zsh)' >> "$HOME/.zshrc"
    echo 'alias k=kubectl' >> "$HOME/.zshrc"
fi

# Helm completion
if ! grep -q "helm completion" "$HOME/.bashrc" 2>/dev/null; then
    echo 'source <(helm completion bash)' >> "$HOME/.bashrc"
fi
if ! grep -q "helm completion" "$HOME/.zshrc" 2>/dev/null; then
    echo 'source <(helm completion zsh)' >> "$HOME/.zshrc"
fi

echo ""
echo "====================================="
echo "Setup Complete!"
echo "====================================="
echo ""
echo "Cloud CLIs installed:"
echo "  - aws (AWS CLI v2)"
echo "  - az (Azure CLI)"
echo "  - gcloud (Google Cloud CLI)"
echo "  - doctl (DigitalOcean)"
echo "  - op (1Password CLI)"
echo ""
echo "Kubernetes tools:"
echo "  - kubectl, k9s, helm, kustomize"
echo "  - kubectx, kubens, stern"
echo ""
echo "IaC tools:"
echo "  - terraform, opentofu, ansible"
echo ""
echo "DevSecOps tools:"
echo "  - trivy, tfsec, checkov, terrascan"
echo "  - grype, syft, hadolint"
echo "  - kubesec, kube-linter"
echo "  - gitleaks, trufflehog"
echo ""
echo "Next steps:"
echo "1. Restart shell or: source ~/.bashrc"
echo "2. Configure cloud CLIs:"
echo "   - aws configure"
echo "   - az login"
echo "   - gcloud init"
echo "   - doctl auth init"
echo "   - op signin"
echo ""
