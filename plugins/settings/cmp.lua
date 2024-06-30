local settings = {
	cmp_style = "default",
	cmp_icons_style = "vscode",
}

local cmp_kinds = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

local opt = vim.opt
local cmp = require("cmp")
local lspkind = require("lspkind")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local tailwindcss_colorizer_cmp = require("tailwindcss-colorizer-cmp")

cmp.setup({
	window = {
		completion = {
			border = "rounded",
			side_padding = settings.cmp_style == "default" and 1 or 0,
			col_offset = settings.cmp_style == "default" and -1 or -4,
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder,Search:None",
		},
		documentation = {
			border = "rounded",
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLineBG,Search:None",
		},
	},
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-e>"] = cmp.mapping.abort(),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-l>"] = cmp.mapping.scroll_docs(-4),
		["<C-h>"] = cmp.mapping.scroll_docs(4),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "cmdline" },
		{ name = "nvim_lsp" },
	}),
	formatting = {
		fields = settings.cmp_style == "nvchad" and { "kind", "abbr", "menu" } or nil,
		format = function(entry, item)
			-- First, use the tailwindcss-colorizer-cmp formatter
			local colorized_fmt = tailwindcss_colorizer_cmp.formatter(entry, item)
			-- Then, apply the lspkind formatting
			local fmt = lspkind.cmp_format({
				mode = "symbol_text",
				maxwidth = 50,
				ellipsis_char = "...",
			})(entry, colorized_fmt)

			-- Further customize formatting as needed
			local strings = vim.split(fmt.kind, "%s", { trimempty = true })

			if settings.cmp_icons_style == "vscode" then
				fmt.kind = " " .. (cmp_kinds[strings[2]] or "")
			else
				fmt.kind = " " .. (strings[1] or "")
			end

			if settings.cmp_style == "nvchad" then
				fmt.kind = fmt.kind .. " "
				fmt.menu = strings[2] ~= nil and ("  " .. (strings[2] or "")) or ""
			else
				fmt.menu = strings[2] ~= nil and (strings[2] or "") or ""
			end

			return fmt
		end,
	},
})
