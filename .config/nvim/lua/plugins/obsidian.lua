return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	-- Load the plugin only if the directory exists
	cond = function()
		return vim.fn.isdirectory(vim.fn.expand("~/Nextcloud/obsidian/player2")) == 1
	end,
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
		-- see below for full list of optional dependencies 👇
	},
	opts = {
		workspaces = {
			{
				name = "Player2",
				path = "~/Nextcloud/obsidian/player2",
			},
			{
				name = "Vault",
				path = "~/Nextcloud/obsidian/vault",
			},
			{
				name = "Notion",
				path = "~/Nextcloud/obsidian/notion",
			},
		},

		templates = {
			folder = "~/Nextcloud/obsidian/player2/templates",
			date_format = "%Y-%m-%d",
			time_format = "%Y%m%d%H%M%S",
		},

		-- Custom function to generate filename with datetime and optional title
		note_id_func = function(title)
			local datetime = os.date("%Y%m%d%H%M%S")
			if title then
				title = title:gsub("[^%w%s-]", ""):gsub("%s+", "-"):lower()
				return datetime .. "-" .. title
			else
				return datetime
			end
		end,

		-- Keybinding for :ObsidianNew with a title
		vim.api.nvim_set_keymap("n", "<leader>on", ":ObsidianTemplate<CR>", { noremap = true, silent = true }),

		-- Either 'wiki' or 'markdown'.
		preferred_link_style = "markdown",

		-- Optional, boolean or a function that takes a filename and returns a boolean.
		-- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
		disable_frontmatter = true,
	},
}
