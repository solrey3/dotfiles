{ ... }: {
  # Enable starship prompt
  # Configuration is managed in traditional dotfiles
  programs.starship.enable = true;

  # Symlink traditional dotfile
  # This makes the traditional starship/starship.toml the source of truth
  home.file.".config/starship.toml" = {
    source = ../../../starship/starship.toml;
  };
}
