{ pkgs, ... }: {
  # Install tmux as a package
  # Do NOT use programs.tmux.enable to avoid home-manager managing .tmux.conf
  home.packages = with pkgs; [
    tmux
  ];

  # Symlink traditional dotfile
  # This makes the traditional tmux/.tmux.conf the source of truth
  home.file.".tmux.conf" = {
    source = ../../../tmux/.tmux.conf;
    force = true;  # Override any existing file/symlink
  };
}
