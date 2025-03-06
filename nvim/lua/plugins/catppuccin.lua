return {
	-- other plugins
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavor = "mocha", -- latte, frappe, macchiato, mocha
				-- other configurations...
			})
			vim.cmd("colorscheme catppuccin")
		end,
	},
}
