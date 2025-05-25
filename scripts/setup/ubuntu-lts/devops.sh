#!/usr/bin/env bash
set -euo pipefail

# Script: setup-devops-tools.sh
# Installs kubectl, k9s, Helm, and Terraform if they’re not already present.

# 1. kubectl
if command -v kubectl &>/dev/null; then
  echo "✅ kubectl is already installed."
else
  echo "🔄 Installing kubectl…"
  K8S_VER=$(curl -L -s https://dl.k8s.io/release/stable.txt)
  curl -LO "https://dl.k8s.io/release/${K8S_VER}/bin/linux/amd64/kubectl"
  chmod +x kubectl
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  rm -f kubectl
  echo "✅ kubectl installed (version ${K8S_VER})."
fi

# 2. k9s
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

# 3. Helm
if command -v helm &>/dev/null; then
  echo "✅ Helm is already installed."
else
  echo "🔄 Installing Helm…"
  curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
  echo "✅ Helm installed (version $(helm version --short))."
fi

# 4. Terraform
if command -v terraform &>/dev/null; then
  echo "✅ Terraform is already installed."
else
  echo "🔄 Installing Terraform…"
  # Add HashiCorp GPG key and repo
  sudo mkdir -p /usr/share/keyrings
  curl -fsSL https://apt.releases.hashicorp.com/gpg \
    | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    | sudo tee /etc/apt/sources.list.d/hashicorp.list >/dev/null

  sudo apt update
  sudo apt install -y terraform
  echo "✅ Terraform installed (version $(terraform version | head -n1))."
fi

# 5. Additional apt-installable DevOps clients
echo "🔄 Installing additional CLI tools via apt: postgresql-client, redis-tools, nmap…"
sudo apt update
sudo apt install -y postgresql-client redis-tools nginx nmap
echo "✅ postgresql-client, redis-tools, and nmap installed."

echo "🎉 All DevOps tools are set up!"