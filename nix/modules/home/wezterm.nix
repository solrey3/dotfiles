{ ... }: {
  # Enable wezterm with shell integration
  # Configuration is managed in traditional dotfiles
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  # Symlink traditional dotfile
  # This makes the traditional wezterm/.wezterm.lua the source of truth
  home.file.".wezterm.lua" = {
    source = ../../../wezterm/.wezterm.lua;
  };
}
