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
  name = "azure-pern-infra";
  packages = with pkgsWithConfig; [
    nodejs
    yarn
    _1password
    nodePackages.cdktf-cli
    nodePackages.cdk8s-cli
    terraform
    terragrunt
    kubectl
    kubernetes-helm
    azure-cli
    postgresql
    nodePackages.typescript
    nodePackages.ts-node
    nodePackages.pg
    nodePackages.express
    nodePackages.react
    nodePackages.react-dom
    nodePackages.create-react-app
  ];

  shellHook = ''
    echo "Entering Azure Setup Environment"
    export NODE_OPTIONS="--max-old-space-size=4096"
    export ENV=${ENV:-dev}
    export DATABASE_URL="postgresql://localhost:5432/mydb"
    echo "Database URL set to $DATABASE_URL"
  '';
}
