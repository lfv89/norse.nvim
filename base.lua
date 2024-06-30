-- Basic Options
vim.opt.scrolloff = 5 -- Keep 5 lines above/below the cursor when scrolling
vim.opt.updatetime = 250 -- Faster updates
vim.opt.timeoutlen = 300 -- Faster timeout for mapped sequences

-- Tabs and Indentation
vim.o.tabstop = 2 -- Number of spaces tabs count for
vim.o.shiftwidth = 2 -- Number of spaces for each step of (auto)indent
vim.o.softtabstop = 2 -- Number of spaces in tab when editing

-- General Settings
vim.opt.list = false -- Show invisible characters
vim.opt.hlsearch = true -- Highlight search results
vim.opt.splitright = true -- Vertical splits to the right
vim.opt.splitbelow = true -- Horizontal splits below
vim.g.have_nerd_font = true -- Nerd Fonts available
vim.o.ruler = true -- Show cursor position
vim.o.cursorline = true -- Highlight current line
vim.o.cursorcolumn = true -- Highlight current column
vim.o.showmatch = true -- Highlight matching brackets
vim.o.showcmd = true -- Show command in status line
vim.o.termguicolors = true -- Enable true color support
vim.o.relativenumber = true -- Show relative line numbers
vim.o.lazyredraw = true -- Redraw only when necessary
vim.o.ttyfast = true -- Assume fast terminal connection
vim.o.hlsearch = true -- Highlight search results
vim.o.ignorecase = true -- Ignore case in search patterns
vim.o.smartcase = true -- Override ignorecase if search has uppercase
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.backup = false -- Disable backup files
vim.o.writebackup = false -- Disable write backup files
vim.o.undofile = true -- Enable persistent undo

-- Custom Paths
vim.o.undodir = "/tmp" -- Location for undo files
vim.o.backupdir = "/tmp" -- Location for backup files
vim.o.directory = "/tmp" -- Location for swap files

-- Leader Key
vim.g.mapleader = " " -- Set leader key to space

-- Clipboard and Command Preview
vim.opt.inccommand = "split" -- Incremental command preview
vim.opt.clipboard = "unnamedplus" -- Use system clipboard

-- Filetype and Syntax
vim.cmd("syntax enable") -- Enable syntax highlighting
vim.cmd("filetype plugin indent on") -- Enable filetype detection and related plugins

-- Autocommands for Auto Save
vim.api.nvim_create_augroup("auto_save", { clear = true })
vim.api.nvim_create_autocmd("FocusLost", {
	group = "auto_save",
	pattern = "*",
	command = "wa",
})

-- Autocommands for Cursor Line and Column
vim.api.nvim_create_augroup("cursorline_cursorcolumn", { clear = true })
vim.api.nvim_create_autocmd("InsertLeave", {
	group = "cursorline_cursorcolumn",
	pattern = "*",
	command = "set cursorline cursorcolumn",
})
vim.api.nvim_create_autocmd("InsertEnter", {
	group = "cursorline_cursorcolumn",
	pattern = "*",
	command = "set nocursorline nocursorcolumn",
})

-- Autocommand for Text Yank Highlight
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Key Mappings
vim.keymap.set("v", "Y", '"+y', { noremap = true }) -- Copy to system clipboard in visual mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { noremap = true }) -- Clear search highlights with <Esc>
vim.keymap.set("n", "q", ":bd!<CR>", { noremap = true }) -- Close buffer with q
vim.keymap.set("n", "<Leader>n", ":cnext<CR>", { noremap = true }) -- Jump to next item in quickfix list
vim.keymap.set("n", "<Leader>p", ":cprevious<CR>", { noremap = true }) -- Jump to previous item in quickfix list
vim.keymap.set("n", "<Leader>r", ":source ~/.config/nvim/init.lua<CR>", { noremap = true }) -- Reload config file
