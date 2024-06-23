-- init.lua

-- Basic settings
vim.o.number = true  -- Show line numbers
vim.o.relativenumber = true  -- Show relative line numbers
vim.o.expandtab = true  -- Use spaces instead of tabs
vim.o.shiftwidth = 4  -- Indentation level
vim.o.tabstop = 4  -- Number of spaces tabs count for
vim.o.smartindent = true  -- Smart indentation
vim.o.clipboard = "unnamedplus"  -- Use system clipboard
vim.o.termguicolors = true  -- Enable 24-bit RGB colors

-- Load plugins using packer.nvim
require("packer").startup(function()
  use "wbthomason/packer.nvim"  -- Plugin manager
  use "nvim-treesitter/nvim-treesitter"  -- Treesitter for better syntax highlighting
  use "neovim/nvim-lspconfig"  -- LSP configurations
  use "hrsh7th/nvim-compe"  -- Auto-completion
  use "nvim-telescope/telescope.nvim"  -- Fuzzy finder
  use "gruvbox-community/gruvbox"  -- Gruvbox color scheme
end)

-- LSP settings
require("lspconfig").pyright.setup{}  -- Example LSP for Python

-- Telescope keybindings
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true })

-- Colorscheme
vim.cmd("colorscheme gruvbox")

