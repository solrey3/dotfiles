{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nnn # terminal file manager

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processer https://github.com/mikefarah/yq
    fzf # A command-line fuzzy finder

    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    caddy
    gnupg

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    iftop # network monitoring

    # system call monitoring
    lsof # list open files

    # system tools
    pciutils # lspci
    
    # my stuff
    gh
    htop
    kubectl
    lazygit
    nodejs
    stow
    tmux
    tokei
    yarn
  ];

  home.file = {
    ".bash_profile".source = ~/dotfiles/.bash_profile;
    ".bashrc".source = ~/dotfiles/.bashrc;
    ".config/nvim".source = ~/dotfiles/.config/nvim;
    ".tmux.conf".source = ~/dotfiles/.tmux.conf;
    ".vimrc".source = ~/dotfiles/.vimrc;
    ".zshrc".source = ~/dotfiles/.zshrc;
  };

  programs = {
    # modern vim
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };

    # skim provides a single executable: sk.
    # Basically anywhere you would want to use grep, try sk instead.
    skim = {
      enable = true;
      enableBashIntegration = true;
    };


    # alacritty - a cross-platform, GPU-accelerated terminal emulator
    alacritty = {
      enable = true;
      # custom settings
      settings = {
        env.TERM = "xterm-256color";
        font = {
          size = 16;
        };
        scrolling.multiplier = 5;
        selection.save_to_clipboard = true;
        # window.padding = { x = 24, y = 24 };
        window.decorations = "Full";
        window.opacity = 0.8;
      };
    };
    
  };
}
