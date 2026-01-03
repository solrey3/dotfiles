{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  # Install LSP servers and tools via Nix
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
