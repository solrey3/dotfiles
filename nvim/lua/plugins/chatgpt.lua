return {
	-- Lazy
	{
		"jackMort/ChatGPT.nvim",
		enabled = false,
		event = "VeryLazy",
		config = function()
			require("chatgpt").setup({
				-- Bitwarden isn't good for this.
				-- api_key_cmd = "bw get password OpenAINeovim",
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"folke/trouble.nvim",
			"nvim-telescope/telescope.nvim",
		},
		extra_curl_params = {
			"-H",
			"Origin: https://openai.com",
		},
	},
}
