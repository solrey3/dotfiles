return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
	--   "BufReadPre path/to/my-vault/**.md",
	--   "BufNewFile path/to/my-vault/**.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
		-- see below for full list of optional dependencies 👇
	},
	opts = {
		workspaces = {
			{
				name = "Player2",
				path = "~/Nextcloud/obsidian/vault/Player2",
			},
		},

		templates = {
			folder = "~/Nextcloud/obsidian/vault/Player2/templates",
			date_format = "%Y-%m-%d-%a",
			time_format = "%H:%M:%S",
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
		vim.api.nvim_set_keymap(
			"n",
			"<leader>on",
			':lua require("obsidian").new_note()<CR>',
			{ noremap = true, silent = true }
		),
	},
}

-- Keybinding for :ObsidianNew with a title
-- vim.api.nvim_set_keymap('n', '<leader>on', ':lua require("obsidian").new_note()<CR>', { noremap = true, silent = true })
