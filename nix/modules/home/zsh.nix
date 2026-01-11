{ pkgs, ... }: {
  # Enable zsh for system integration
  # Configuration is managed in traditional dotfiles
  programs.zsh.enable = true;

  # Symlink traditional dotfile
  # This makes the traditional zsh/.zshrc the source of truth
  home.file.".zshrc" = {
    source = ../../../zsh/.zshrc;
  };

  # Install oh-my-zsh and plugins via packages
  # Traditional .zshrc manages oh-my-zsh configuration
  home.packages = with pkgs; [
    zsh
    oh-my-zsh
  ];
}
