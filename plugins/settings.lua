require("colorizer").setup()
require("nvim-surround").setup()

-- lualine
-- ----------------------------
require("lualine").setup({
	options = { theme = "nord" },
})
-------------------------------

-- colorscheme
-- -----------------------------
vim.cmd([[colorscheme onenord]])
--------------------------------

-- better-escape.nvim
--------------------------------
require("better_escape").setup({
	keys = "<Esc>",
	mapping = { "jk", "jj" },
	clear_empty_lines = false,
	timeout = vim.o.timeoutlen,
})
--------------------------------

-- nvim-autopairs
-- -------------------------------
require("nvim-autopairs").setup({
	event_type = "InsertEnter",
	config = {
		enable = true,
	},
})
----------------------------------

-- nvim-ufo
-------------------------------------------------------
require("ufo").setup({
	provider_selector = function(_, _, _)
		return { "treesitter", "indent" }
	end,
})

vim.o.foldlevel = 99
vim.o.foldcolumn = "1"
vim.o.foldenable = true
vim.o.foldlevelstart = 99

vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
-------------------------------------------------------

-- neogit
-----------------------------------------------------------------------------------------------------------------------
vim.cmd([[cabbrev gs Neogit]])
vim.cmd([[cabbrev gp NeogitPushForce]])

vim.cmd(
	[[command! -nargs=0 NeogitPushForce lua require('neogit').action('push', 'to_upstream', { '--force-with-lease' })()]]
)
-----------------------------------------------------------------------------------------------------------------------
