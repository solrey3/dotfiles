-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.md",
  callback = function(args)
    local filepath = vim.api.nvim_buf_get_name(args.buf)
    if filepath:match("/templates/") then
      -- Disable formatting for markdown files in the templates directory
      vim.b.disable_autoformat = true
    else
      -- Ensure it's not disabled for other markdown files
      vim.b.disable_autoformat = false
    end
  end,
})
