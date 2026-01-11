{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  # Symlink LazyVim configuration from traditional dotfiles
  # This uses the nvim/ directory from the dotfiles repository
  home.file.".config/nvim" = {
    source = ../../../nvim;
    recursive = true;
  };

  # Install LSP servers and tools via Nix
  # These complement the LazyVim configuration
  home.packages = with pkgs; [
    # LSP servers
    marksman              # Markdown LSP
    lua-language-server   # Lua LSP
    nil                   # Nix LSP
    nodePackages.bash-language-server
    nodePackages.typescript-language-server
    pyright
    rust-analyzer
    gopls
    clang-tools

    # Tree-sitter CLI and common parsers
    tree-sitter
    vimPlugins.nvim-treesitter.withAllGrammars
  ];
}
