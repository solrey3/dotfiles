{ pkgs }:

let
  pkgsWithConfig = import pkgs.path {
    config = {
      allowUnfree = true;
    };
    inherit (pkgs) system;
  };
in
pkgsWithConfig.mkShell {
  name = "devops-environment";
  packages = with pkgsWithConfig; [
    # Containerization Tools
    docker
    docker-compose
    kubectl
    minikube
    helm

    # Infrastructure as Code
    terraform
    terraform-ls  # Terraform Language Server
    terragrunt
    python3Packages.cdk8s
    cdktf

    # Diagrams and Visualization
    python3Packages.diagrams

    # Cloud Provider CLIs
    awscli2
    azure-cli
    google-cloud-sdk
    doctl        # DigitalOcean CLI
    gh           # GitHub CLI

    # Password Managers and Secret Management
    op           # 1Password CLI
    bitwarden-cli
    vault        # HashiCorp Vault

    # Additional Utilities
    git
    jq
    yq
    kubectx
    k9s
  ];

  shellHook = ''
    echo "Entering DevOps Environment"
  '';
}
