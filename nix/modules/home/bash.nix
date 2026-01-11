{ ... }: {
  # Enable bash for system integration
  # Configuration is managed in traditional dotfiles
  programs.bash.enable = true;

  # Symlink traditional dotfiles
  # This makes the traditional bash/.bashrc and bash/.bash_profile the source of truth
  home.file.".bashrc" = {
    source = ../../../bash/.bashrc;
  };

  home.file.".bash_profile" = {
    source = ../../../bash/.bash_profile;
  };
}
