{ ... }: {
  # Enable alacritty but don't manage settings in Nix
  # Configuration is managed in traditional dotfiles
  programs.alacritty.enable = true;

  # Symlink traditional dotfile
  # This makes the traditional alacritty/alacritty.toml the source of truth
  home.file.".config/alacritty/alacritty.toml" = {
    source = ../../../alacritty/alacritty.toml;
  };
}
