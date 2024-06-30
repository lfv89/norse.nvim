local lazy = require("lazy")

lazy.setup({
	-- Colors
	-- ------
	{ "rmehri01/onenord.nvim", event = "ColorScheme" },
	{ "lfv89/vim-interestingwords", keys = { "<Leader>k" } },

	-- General Utilities,
	-- Enhancements, etc
	-- ---------------------
	{ "github/copilot.vim" },
	{ "nvim-lua/plenary.nvim" },
	{ "windwp/nvim-autopairs" },
	{ "roxma/vim-tmux-clipboard" },

	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPost",
		config = function()
			require("vim.plugins.settings.treesitter")
		end,
		dependencies = {
			{ "RRethy/nvim-treesitter-endwise" },
		},
	},

	-- Git
	-- ---
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
		},
		config = true,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPost",
		config = function()
			require("vim.plugins.settings.gitsigns")
		end,
	},

	-- Text Editing
	-- ------------
	{ "kylechui/nvim-surround" },
	{ "max397574/better-escape.nvim" },
	{ "tpope/vim-rsi", event = "InsertEnter" },

	{
		"numToStr/Comment.nvim",
		keys = {
			{ "gcc", mode = "n", desc = "comment toggle current line" },
			{ "gbc", mode = "n", desc = "comment toggle current block" },
			{ "gc", mode = { "n", "o" }, desc = "comment toggle linewise" },
			{ "gc", mode = "x", desc = "comment toggle linewise (visual)" },
			{ "gb", mode = { "n", "o" }, desc = "comment toggle blockwise" },
			{ "gb", mode = "x", desc = "comment toggle block'ise (visual)" },
		},
		config = function()
			require("Comment").setup()
		end,
	},

	-- LSPs, Formatters,
	-- Diagnostics and etc
	-- -------------------
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		config = function()
			require("vim.plugins.settings.conform")
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = "InsertEnter",
		config = function()
			require("vim.plugins.settings.lsp")
		end,
		dependencies = {
			{ "folke/neodev.nvim" },
			{ "j-hui/fidget.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "williamboman/mason.nvim", config = true },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
		},
	},

	-- Navigation
	-- ----------
	{ "christoomey/vim-tmux-navigator" },
	{ "tmux-plugins/vim-tmux-focus-events" },
	{ "unblevable/quick-scope", keys = { "f", "F", "t", "T" } },

	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			{ "kevinhwang91/promise-async" },
		},
	},

	{
		"stevearc/oil.nvim",
		keys = "<Leader>o",
		config = function()
			require("vim.plugins.settings.oil")
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		keys = "<C-f>",
		config = function()
			require("vim.plugins.settings.tree")
		end,
		dependencies = {
			{ "kyazdani42/nvim-web-devicons" },
		},
	},

	-- User Interface Components
	-- -------------------------
	{ "nvim-lualine/lualine.nvim" },
	{ "norcalli/nvim-colorizer.lua" },

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},

	{
		"nvim-telescope/telescope.nvim",
		keys = { "<C-p>" },
		cmd = { "Telescope", "Easypick" },
		config = function()
			require("vim.plugins.settings.telescope")
		end,
		dependencies = {
			{ "axkirillov/easypick.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("vim.plugins.settings.cmp")
		end,
		dependencies = {
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/vim-vsnip" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "onsails/lspkind.nvim" },
			{ "roobert/tailwindcss-colorizer-cmp.nvim" },
		},
	},
})
