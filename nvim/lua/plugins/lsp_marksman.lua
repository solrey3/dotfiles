return {
  -- This uses LazyVim's built-in LSP support
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      marksman = {
        cmd = { "marksman", "server" }, -- use system marksman (Nix)
      },
    },
  },
}
