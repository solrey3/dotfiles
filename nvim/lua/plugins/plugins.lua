return {
	-- single liners here --
	{
		"junegunn/fzf",
		run = function()
			vim.fn["fzf#install"]()
		end,
	},
	{ "junegunn/fzf.vim" },
	{ "hashivim/vim-terraform" },
	{ "github/copilot.vim" },
}
