{ pkgs, ... }: {
  # Install zsh and oh-my-zsh as packages
  # Do NOT use programs.zsh.enable to avoid home-manager managing .zshrc
  home.packages = with pkgs; [
    zsh
    oh-my-zsh
  ];

  # Symlink traditional dotfile
  # This makes the traditional zsh/.zshrc the source of truth
  home.file.".zshrc" = {
    source = ../../../zsh/.zshrc;
    force = true;  # Override any existing file/symlink
  };
}
