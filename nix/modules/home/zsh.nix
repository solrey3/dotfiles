{ config, lib, pkgs, ... }: {

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "z" "sudo" "kubectl" ];
    };
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    shellAliases = {
      # Traditional ls replacements with eza
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      lt = "eza -T";
      lg = "eza -l --git";
      
      # fd aliases
      find = "fd";
      
      # Other aliases
      hist = "history 1";
      p2 = "cd ~/Nextcloud/obsidian/player2; nvim readme.md";
      nc = "cd ~/nix-config; nvim README.md";
      nano = "nvim";
      neofetch = "fastfetch";
      k = "kubectl";
    };
    initContent = lib.mkBefore ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      
      # Initialize zoxide
      eval "$(zoxide init zsh)"
    '';
  };

  home.packages = with pkgs; [
    zsh
    oh-my-zsh
  ];

}
