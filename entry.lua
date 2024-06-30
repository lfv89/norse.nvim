vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local config_path = vim.fn.stdpath("config")
local dotfiles_path = config_path .. "/../../Documents/Development/Dotfiles"

package.path = package.path .. ";" .. dotfiles_path .. "/?.lua"

require("vim.base")
require("vim.plugins.registry")
require("vim.plugins.settings")
