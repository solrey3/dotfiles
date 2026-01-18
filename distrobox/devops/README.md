# Distrobox DevOps Environment

Arch Linux-based DevOps and DevSecOps container for cloud infrastructure, Kubernetes, and security scanning.

## Contents

- **Dockerfile** - Arch Linux image with DevOps tools pre-installed
- **setup.sh** - Post-creation script for additional tools and configurations
- **distrobox.ini** - Assemble manifest for quick container creation

## Quick Start

```bash
# Build the image
podman build -t distrobox-devops ~/.dotfiles/distrobox/devops/

# Create the container
distrobox create -i distrobox-devops -n devops

# Enter the container
distrobox enter devops

# Run the setup script (first time only)
distrobox-setup
```

## Alternative: Using Assemble

```bash
# Build image first
podman build -t distrobox-devops ~/.dotfiles/distrobox/devops/

# Create via assemble manifest
distrobox assemble create --file ~/.dotfiles/distrobox/devops/distrobox.ini
```

## Included Tools

### Cloud CLIs

| Tool | Description |
|------|-------------|
| aws | AWS CLI v2 |
| az | Azure CLI |
| gcloud | Google Cloud CLI (via setup.sh) |
| doctl | DigitalOcean CLI |
| op | 1Password CLI (via setup.sh) |

### Kubernetes

| Tool | Description |
|------|-------------|
| kubectl | Kubernetes CLI |
| k9s | Kubernetes TUI |
| helm | Kubernetes package manager |
| kustomize | Kubernetes configuration management |
| kubectx/kubens | Context and namespace switcher |
| stern | Multi-pod log tailing |

### Infrastructure as Code

| Tool | Description |
|------|-------------|
| terraform | HashiCorp Terraform |
| opentofu | Open source Terraform fork |
| ansible | Configuration management |

### Container Tools

| Tool | Description |
|------|-------------|
| podman | Container runtime |
| buildah | Container image builder |
| skopeo | Container image operations |
| dive | Container image analyzer |

### DevSecOps - Security Scanning

| Tool | Description |
|------|-------------|
| trivy | Container/IaC vulnerability scanner |
| tfsec | Terraform security scanner |
| checkov | IaC security scanner |
| terrascan | IaC security scanner |
| grype | Vulnerability scanner |
| syft | SBOM generator |
| hadolint | Dockerfile linter |
| kubesec | Kubernetes manifest scanner |
| kube-linter | Kubernetes manifest linter |
| gitleaks | Git secret scanner |
| trufflehog | Secret scanner |

### General Tools

| Tool | Description |
|------|-------------|
| neovim | Editor |
| gh | GitHub CLI |
| lazygit | Git TUI |
| fzf, fd, ripgrep | Search tools |
| httpie | HTTP client |
| jq, yq | JSON/YAML processors |

## Post-Setup

After running `distrobox-setup`:

1. Restart shell or `source ~/.bashrc`
2. Configure cloud providers:
   ```bash
   aws configure
   az login
   gcloud init
   doctl auth init
   op signin
   ```
3. Configure Kubernetes:
   ```bash
   # Add cluster configs to ~/.kube/config
   kubectl config get-contexts
   ```

## Common Workflows

### Security Scan a Terraform Project

```bash
cd /path/to/terraform
tfsec .
checkov -d .
terrascan scan
```

### Scan Container Images

```bash
trivy image myimage:tag
grype myimage:tag
syft myimage:tag  # Generate SBOM
```

### Scan Kubernetes Manifests

```bash
kubesec scan deployment.yaml
kube-linter lint manifests/
```

### Scan for Secrets

```bash
gitleaks detect --source .
trufflehog filesystem .
```

### Lint Dockerfiles

```bash
hadolint Dockerfile
```

## Using with Dotfiles

```bash
# Inside the container, your home directory is shared
cd ~/.dotfiles
./scripts/stow/dotfiles.sh
```
