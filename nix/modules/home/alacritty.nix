{ pkgs, ... }: {
  # Install alacritty as a package
  # Do NOT use programs.alacritty.enable to avoid home-manager managing alacritty.toml
  home.packages = with pkgs; [
    alacritty
  ];

  # Symlink traditional dotfile
  # This makes the traditional alacritty/alacritty.toml the source of truth
  home.file.".config/alacritty/alacritty.toml" = {
    source = ../../../alacritty/alacritty.toml;
    force = true;  # Override any existing file/symlink
  };
}
