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
  name = "python-fasthtml";
  packages = with pkgsWithConfig; [
    python3
  ];

  shellHook = ''
    if [ ! -d ".venv" ]; then
      python3 -m venv .venv
    fi
    source .venv/bin/activate
    pip install --upgrade pip
    pip install python-fasthtml
    echo "Entering Python FastHTML Environment"
  '';
}
