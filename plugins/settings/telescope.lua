vim.cmd([[
  highlight TelescopeSelection gui=bold
]])

vim.cmd([[
  highlight TelescopeSelection guibg=#353B49 guifg=#ffffff
]])

require("telescope").setup({
	defaults = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		mappings = {
			n = { ["q"] = require("telescope.actions").close },
		},
		layout_config = {
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
			vertical = {
				mirror = false,
			},
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
		},
		vimgrep_arguments = {
			"rg",
			"-L",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},

		border = {},
		winblend = 0,
		entry_prefix = "  ",
		color_devicons = true,
		prompt_prefix = "   ",
		selection_caret = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		path_display = { "truncate" },
		layout_strategy = "horizontal",
		file_ignore_patterns = { "node_modules" },
		set_env = { ["COLORTERM"] = "truecolor" },
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
	},

	extensions = {},
	extensions_list = { "themes", "terms" },
})

local easypick = require("easypick")

local get_default_branch = "git rev-parse --symbolic-full-name refs/remotes/origin/HEAD | sed 's!.*/!!'"
local base_branch = vim.fn.system(get_default_branch) or "main"

easypick.setup({
	pickers = {
		{
			name = "Files with Changes",
			command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
			previewer = easypick.previewers.branch_diff({ base_branch = base_branch }),
		},
	},
})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.git_commits, {})
vim.keymap.set("n", "<leader>fc", ":Easypick Files with Changes<CR>", {})
