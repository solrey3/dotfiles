{ ... }: {
  # Enable ghostty
  # Configuration is managed in traditional dotfiles
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  # Symlink traditional dotfile
  # This makes the traditional ghostty/config the source of truth
  home.file.".config/ghostty/config" = {
    source = ../../../ghostty/config;
  };
}
