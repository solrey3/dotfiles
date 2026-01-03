{ ... }: {
  # Bash configuration
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      
      # Initialize zoxide
      eval "$(zoxide init bash)"
      
      # Traditional ls replacements with eza
      alias ls="eza"
      alias ll="eza -l"
      alias la="eza -la"
      alias lt="eza -T"
      alias lg="eza -l --git"
      
      # fd aliases
      alias find="fd"
      
      # Other aliases
      alias hist="history 1"
      alias p2="cd ~/Nextcloud/obsidian/player2; nvim readme.md"
      alias nc="cd ~/nix-config; nvim README.md"
      alias dtf="cd ~/nix-config/config; nvim"
      alias nano="nvim"
      alias neofetch="fastfetch"
    '';
    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };
}
