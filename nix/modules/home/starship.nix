{ pkgs, ... }: {
  # Install starship as a package
  # Do NOT use programs.starship.enable to avoid home-manager managing starship.toml
  home.packages = with pkgs; [
    starship
  ];

  # Symlink traditional dotfile
  # This makes the traditional starship/starship.toml the source of truth
  home.file.".config/starship.toml" = {
    source = ../../../starship/starship.toml;
    force = true;  # Override any existing file/symlink
  };
}
