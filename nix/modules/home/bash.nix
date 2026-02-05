{ pkgs, ... }: {
  # Install bash as a package
  # Do NOT use programs.bash.enable to avoid home-manager managing .bashrc/.bash_profile
  home.packages = with pkgs; [
    bash
  ];

  # Symlink traditional dotfiles
  # This makes the traditional bash/.bashrc and bash/.bash_profile the source of truth
  home.file.".bashrc" = {
    source = ../../../bash/.bashrc;
    force = true;  # Override any existing file/symlink
  };

  home.file.".bash_profile" = {
    source = ../../../bash/.bash_profile;
    force = true;  # Override any existing file/symlink
  };
}
