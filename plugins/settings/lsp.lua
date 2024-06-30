local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = { "gopls", "solargraph", "cssls", "html", "dartls" }
local tooling = { "goimports", "prettier", "rubocop", "stylua", "prettierd" }

require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = servers })
require("mason-tool-installer").setup({ ensure_installed = tooling })

require("fidget").setup({
	progress = {
		ignore = {},
		poll_rate = 0,
		suppress_on_insert = false,
		ignore_done_already = false,
		ignore_empty_message = false,

		clear_on_detach = function(client_id)
			local client = vim.lsp.get_client_by_id(client_id)
			return client and client.name or nil
		end,

		notification_group = function(msg)
			return msg.lsp_client.name
		end,

		display = {
			render_limit = 16, -- How many LSP messages to show at once
			done_ttl = 3, -- How long a message should persist after completion
			done_icon = "✔", -- Icon shown when all LSP progress tasks are complete
			done_style = "Constant", -- Highlight group for completed LSP tasks
			progress_ttl = math.huge, -- How long a message should persist when in progress
			-- Icon shown when LSP progress tasks are in progress
			progress_icon = { pattern = "dots", period = 1 },
			-- Highlight group for in-progress LSP tasks
			progress_style = "WarningMsg",
			group_style = "Title", -- Highlight group for group name (LSP server name)
			icon_style = "Question", -- Highlight group for group icons
			priority = 30, -- Ordering priority for LSP notification group
			skip_history = true, -- Whether progress notifications should be omitted from history
			-- How to format a progress message
			format_message = require("fidget.progress.display").default_format_message,
			-- How to format a progress annotation
			format_annote = function(msg)
				return msg.title
			end,
			-- How to format a progress notification group's name
			format_group_name = function(group)
				return tostring(group)
			end,
			overrides = { -- Override options from the default notification config
				rust_analyzer = { name = "rust-analyzer" },
			},
		},

		lsp = {
			progress_ringbuf_size = 0, -- Configure the nvim's LSP progress ring buffer size
			log_handler = false, -- Log `$/progress` handler invocations (for debugging)
		},
	},

	notification = {
		poll_rate = 10, -- How frequently to update and render notifications
		filter = vim.log.levels.INFO, -- Minimum notifications level
		history_size = 128, -- Number of removed messages to retain in history
		override_vim_notify = false, -- Automatically override vim.notify() with Fidget

		configs = { default = require("fidget.notification").default_config },

		redirect = function(msg, level, opts)
			if opts and opts.on_open then
				return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
			end
		end,

		view = {
			stack_upwards = false, -- Display notification items from bottom to top
			icon_separator = " ", -- Separator between group name and icon
			group_separator = "---", -- Separator between notification groups
			group_separator_hl = "Comment",
			render_message = function(msg, cnt)
				return cnt == 1 and msg or string.format("(%dx) %s", cnt, msg)
			end,
		},

		window = {
			normal_hl = "Comment", -- Base highlight group in the notification window
			winblend = 100, -- Background color opacity in the notification window
			border = "rounded", -- Border around the notification window
			zindex = 45, -- Stacking priority of the notification window
			max_width = 0, -- Maximum width of the notification window
			max_height = 0, -- Maximum height of the notification window
			x_padding = 0, -- Padding from right edge of window boundary
			y_padding = 0, -- Padding from bottom edge of window boundary
			align = "top", -- How to align the notification window
			relative = "editor", -- What the notification window position is relative to
		},
	},

	integration = {
		["nvim-tree"] = {
			enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
		},
		["xcodebuild-nvim"] = {
			enable = true, -- Integrate with wojciech-kulik/xcodebuild.nvim (if installed)
		},
	},

	logger = {
		level = vim.log.levels.WARN, -- Minimum logging level
		max_size = 10000, -- Maximum log file size, in KB
		float_precision = 0.01, -- Limit the number of decimals displayed for floats
		path = string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache")),
	},
})

for _, server in ipairs(servers) do
	lspconfig[server].setup({
		capabilities = capabilities,
	})
end

for _, server in ipairs(servers) do
	lspconfig[server].setup({
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			local buf_set_keymap = vim.api.nvim_buf_set_keymap
			local opts = { noremap = true, silent = true }

			buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
			buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)

			if client.server_capabilities.documentHighlightProvider then
				local highlight_augroup = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					group = highlight_augroup,
					buffer = bufnr,
					callback = vim.lsp.buf.document_highlight,
				})
				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					group = highlight_augroup,
					buffer = bufnr,
					callback = vim.lsp.buf.clear_references,
				})
			end
		end,
	})
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
		map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
		map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
		map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.server_capabilities.documentHighlightProvider then
			local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
				end,
			})
		end
	end,
})
