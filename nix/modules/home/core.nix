{ pkgs, ... }:
{
  home.packages = with pkgs; [
    
    ## Custom Scripts
    (writeShellScriptBin "tmux_startup" ''
      #!/bin/bash

      # Function to create a new Tmux session
      create_session() {
        session_name=$1
        window_name=$2
        command=$3

        tmux new-session -d -s "$session_name" -n "$window_name"
        tmux send-keys -t "$session_name:$window_name" "$command" C-m
      }

      # Function to create a new window in an existing session
      create_window() {
        session_name=$1
        window_name=$2
        command=$3

        tmux new-window -t "$session_name" -n "$window_name"
        tmux send-keys -t "$session_name:$window_name" "$command" C-m
      }

      # Create Yo session with 3 windows
      create_session "Yo" "Nix" "cd ~/.nix-config/"
      create_window "Yo" "Dotfiles" "cd ~/.dotfiles"
      create_window "Yo" "Player2" "cd ~/Documents/Notes; nvim todo.md"
      create_window "Yo" "Obsidian" "cd ~/Nextcloud/Obsidian-Code/; nvim"
      create_window "Yo" "Proper" "cd ~/Nextcloud/Proper/; nvim"
      create_window "Yo" "Work" "cd ~/Documents/Notes; nvim"

      # Select the Player2 window
      tmux select-window -t "Yo:Player2"

      # Attach to the Home session by default
      tmux attach-session -t Yo
    '')

    ## Fonts
    nerd-fonts.jetbrains-mono  # Nerd Font with JetBrains Mono
    # (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    ## CLI Tools

    ### System Utilities
    file          # Determine file type
    lsof          # List open files
    gawk          # GNU awk utility
    jq            # Lightweight and flexible command-line JSON processor
    gcc           # GNU Compiler Collection
    gnupg         # GNU Privacy Guard
    gnused        # GNU version of the sed stream editor
    gnutar        # GNU version of the tar archiving utility
    just          # Handy command runner
    which         # Shows the full path of shell commands
    tldr          # Simplified and community-driven man pages
    coreutils     # To overrride BSD tools (g-prefixed versions)
    util-linux    # Miscellaneous system utilities (includes uuidgen)
    fastfetch     # Fast system information tool written in C

    ### File & Directory Management
    tree          # Displays directories as trees (with optional color/HTML output)
    stow          # Symlink farm manager
    mc            # Midnight Commander, a file manager
    nnn           # Terminal file manager

    ### Search & Navigation
    ripgrep       # Recursively searches directories for a regex pattern
    fzf           # Command-line fuzzy finder
    zoxide        # A smarter cd command, inspired by z and autojump
    eza           # A modern replacement for ls
    fd            # A simple, fast and user-friendly alternative to find

    ### Terminal UI & Display
    # ncurses       # System for text-based user interfaces

    ## Monitoring Tools
    btop          # A monitor of resources
    # htop          # Interactive process viewer

    ## Network Tools
    curl          # For making HTTP requests and downloading files
    wget          # Network downloader
    nmap          # Network exploration and security auditing utility
    rsync         # Fast incremental file transfer utility
    speedtest-cli # Internet speed testing tool

    ## Development Tools
    lazygit       # Simple terminal UI for git commands
    postgresql    # Object-relational database management system
    tokei         # Counts code, comments, and blanks lines
    cargo         # Downloads your Rust project's dependencies and builds your project
    rustc         # Safe, concurrent, practical language (wrapper script)
    # marksman      # Language server for Markdown (.NET - has runtime issues)
    markdown-oxide # Rust-based markdown LSP server inspired by Obsidian
    # mpls          # Live preview of markdown using Language Server Protocol
    codex         # Lightweight coding agent that runs in your terminal
    fabric-ai     # Modular framework for solving specific problems using a crowdsourced set of AI prompts

    ## DevOps Tools
    # kubectl          # Kubernetes CLI
    # terraform        # Infrastructure as Code
    # terraformer      # CLI tool to generate terraform files from existing infrastructure (reverse Terraform). Infrastructure to Code
    # kubernetes-helm  # The Kubernetes Package Manager
    # minikube         # Run Kubernetes locally
    # kind             # Run local Kubernetes clusters using Docker container nodes
    # act              # Run GitHub Actions locally
    # k9s              # Kubernetes terminal UI

    ## Cloud Platform CLIs
    _1password-cli   # Password Manager
    #bitwarden-cli  # Password Manager
    # awscli2          # AWS Command Line Interface
    # azure-cli        # Azure Command Line Interface
    # doctl            # DigitalOcean Command Line Interface
    # (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin]) # Google Cloud SDK with GKE Auth Plugin

    ## Fun Tools
    cbonsai       # Bonsai tree generator
    cowsay        # Configurable speaking/thinking cow
    cmatrix       # Simulates the display from "The Matrix"
    figlet        # Banner generator
    fortune       # Print a random, hopefully interesting, adage

    ## Archives and Compression Tools
    p7zip         # File archiver with high compression ratio
    unzip         # Decompression utility for .zip files
    xz            # Lossless data compression tool
    zip           # Compression utility

    ## Multimedia Tools
    ffmpeg        # A complete solution to record, convert, and stream audio and video
    yt-dlp        # A YouTube downloader with additional features and bug fixes

    ## Python Utilities
    python313
    python313Packages.python-frontmatter

  ];

  # GitHub CLI configuration
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "https";
    };
  };

}
