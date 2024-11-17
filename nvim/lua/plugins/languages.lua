-- lua/plugins/languages.lua

return {
	-- LSP Config
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },

	-- Treesitter
	{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },

	-- Autocompletion
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/vim-vsnip" },
	{ "hrsh7th/cmp-vsnip" },
	{ "rafamadriz/friendly-snippets" },

	-- Additional plugins for specific languages
	{ "nvim-treesitter/playground" },
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{ "b0o/schemastore.nvim" },
	-- { "nvimtools/none-ls.nvim" },
	{ "mfussenegger/nvim-lint" },
	{ "mfussenegger/nvim-dap" },

	-- Language specific plugins
	{ "dense-analysis/ale" }, -- Linting

	-- Git integration
	{ "tpope/vim-fugitive" },
	{ "lewis6991/gitsigns.nvim" },

	-- Commenting
	{ "tpope/vim-commentary" },

	-- File explorer
	{ "kyazdani42/nvim-tree.lua" },

	-- Status line
	{ "nvim-lualine/lualine.nvim" },

	-- Fuzzy finder
	{ "nvim-telescope/telescope.nvim" },
	{ "nvim-lua/plenary.nvim" },

	-- Colorscheme
	{ "gruvbox-community/gruvbox" },

	-- Additional utilities
	{ "windwp/nvim-autopairs" },
	{ "tpope/vim-surround" },
	{ "junegunn/vim-easy-align" },

	config = function()
		-- Ensure Treesitter parsers are installed
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"python",
				"typescript",
				"tsx",
				"json",
				"yaml",
				"sql",
				"terraform",
				"lua",
				"vim",
				"markdown",
				"markdown_inline",
				"javascript",
				"nix",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "markdown" },
			},
			indent = {
				enable = true,
			},
		})

		-- Setup LSP servers
		local lspconfig = require("lspconfig")
		local servers = {
			"pyright",
			"tsserver",
			"terraformls",
			"bashls",
			"jsonls",
			"yamlls",
			"sqls",
			"vimls",
			"marksman",
			"eslint",
			"sumneko_lua",
			"rnix",
		}

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = servers,
		})

		for _, lsp in ipairs(servers) do
			lspconfig[lsp].setup({
				capabilities = require("cmp_nvim_lsp").default_capabilities(
					vim.lsp.protocol.make_client_capabilities()
				),
			})
		end

		-- Setup completion
		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body)
				end,
			},
			mapping = {
				["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
				["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
				["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
				["<C-e>"] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "vsnip" },
			}, {
				{ name = "buffer" },
			}),
		})

		-- Setup ALE for linting
		vim.g.ale_linters = {
			python = { "flake8", "mypy", "pylint" },
			typescript = { "tslint", "eslint" },
			javascript = { "eslint" },
			terraform = { "tflint" },
			bash = { "shellcheck" },
			yaml = { "yamllint" },
			json = { "jsonlint" },
			sql = { "sqlint" },
			markdown = { "markdownlint" },
			lua = { "luacheck" },
			nix = { "nix-linter" },
		}
		vim.g.ale_fixers = {
			python = { "black", "isort" },
			typescript = { "prettier" },
			javascript = { "prettier" },
			terraform = { "terraform" },
			bash = { "shfmt" },
			yaml = { "prettier" },
			json = { "prettier" },
			sql = { "sqlformat" },
			markdown = { "prettier" },
			lua = { "stylua" },
			nix = { "nixpkgs-fmt" },
		}
		vim.g.ale_fix_on_save = 1
	end,
}
