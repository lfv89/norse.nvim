require("gitsigns").setup({
	numhl = false,
	linehl = false,
	sign_priority = 6,
	word_diff = false,
	signcolumn = true,
	auto_attach = true,
	update_debounce = 100,
	status_formatter = nil,
	max_file_length = 40000,
	current_line_blame = true,
	attach_to_untracked = false,

	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},

	watch_gitdir = {
		follow_files = true,
	},

	preview_config = {
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},

	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol",
		delay = 1000,
		ignore_whitespace = false,
		virt_text_priority = 100,
	},

	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end)

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end)

		map("n", "<leader>hs", gitsigns.stage_hunk)
		map("n", "<leader>hr", gitsigns.reset_hunk)
		map("v", "<leader>hs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)
		map("v", "<leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)
		map("n", "<leader>hS", gitsigns.stage_buffer)
		map("n", "<leader>hu", gitsigns.undo_stage_hunk)
		map("n", "<leader>hR", gitsigns.reset_buffer)
		map("n", "<leader>hp", gitsigns.preview_hunk)
		map("n", "<leader>hb", function()
			gitsigns.blame_line({ full = true })
		end)
		map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
		map("n", "<leader>hd", gitsigns.diffthis)
		map("n", "<leader>hD", function()
			gitsigns.diffthis("~")
		end)
		map("n", "<leader>td", gitsigns.toggle_deleted)

		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,

	current_line_blame_formatter_opts = {
		relative_time = false,
	},

	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
})
