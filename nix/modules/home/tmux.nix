{ ... }: {
  # Enable tmux
  # Configuration is managed in traditional dotfiles
  programs.tmux.enable = true;

  # Symlink traditional dotfile
  # This makes the traditional tmux/.tmux.conf the source of truth
  home.file.".tmux.conf" = {
    source = ../../../tmux/.tmux.conf;
  };
}
