require("core.options")
require("core.keymaps")

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function()
		local curr_pos = vim.fn.getpos(".")
		pcall(function() vim.cmd [[%s/\s\+$//e]] end)
		vim.fn.setpos(".", curr_pos)
	end
})

vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.ai" },
	{ src = "https://github.com/echasnovski/mini.comment" },
	{ src = "https://github.com/echasnovski/mini.move" },
	{ src = "https://github.com/echasnovski/mini.pairs" },
	{ src = "https://github.com/echasnovski/mini.surround" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/RRethy/base16-nvim" },
	{ src = "https://github.com/tpope/vim-dadbod" },
	{ src = "https://github.com/kristijanhusak/vim-dadbod-ui" },
	{ src = "https://github.com/kristijanhusak/vim-dadbod-completion" },
	{ src = "https://github.com/github/copilot.vim" },
	{ src = "https://github.com/monkoose/neocodeium" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/kdheepak/lazygit.nvim" },
})

require("mason").setup({
	ui = {
		border = "rounded",
		backdrop = 100,
		width = math.floor(0.75 * vim.o.columns),
		height = math.floor(0.75 * vim.o.lines),
		icons = {
			package_installed = "",
			package_pending = "",
			package_uninstalled = ""
		}
	}
})

vim.keymap.set("n", "<leader>m", ":Mason<cr>", { desc = "open mason" })

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"tinymist",
		"gopls",
		"golangci_lint_ls",
		"clangd"
	}
})

require("blink.cmp").setup({
	signature = { enabled = true },
	completion = {
		menu = {
			auto_show = true,
			draw = {
				treesitter = { "lsp" },
				columns = {
					{ "kind_icon", "label", "label_description", gap = 1 },
					{ "kind" }
				}
			}
		},
		documentation = {
			auto_show = false,
			auto_show_delay_ms = 0
		}
	},
	keymap = {
		preset = "default",
		["<cr>"] = { "accept", "fallback" },
		["<A-k>"] = { "select_prev", "fallback" },
		["<A-j>"] = { "select_next", "fallback" },
		["<C-c>"] = { "hide", "fallback" },
	}
})

require("luasnip").setup({ enable_autosnippets = true })
require("luasnip.loaders.from_lua").load({ paths = { "./snippets" } })

vim.keymap.set({ "i" }, "<C-f>", function() require("luasnip").expand() end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-e>", function() require("luasnip").jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-r>", function() require("luasnip").jump(-1) end, { silent = true })

vim.keymap.set("n", "<leader>|", ":vs<cr>", { desc = "split vertically" })
vim.keymap.set("n", "<leader>-", ":sp<cr>", { desc = "split horizontally" })

vim.keymap.set("n", "<C-h>", ":winc h<cr>", { desc = "move to left window" })
vim.keymap.set("n", "<C-l>", ":winc l<cr>", { desc = "move to right window" })
vim.keymap.set("n", "<C-k>", ":winc k<cr>", { desc = "move to top window" })
vim.keymap.set("n", "<C-j>", ":winc j<cr>", { desc = "move to bottom window" })

vim.keymap.set("n", "<leader>w", ":w<cr>", { desc = "write entire buffer to current file" })
vim.keymap.set("n", "<leader>q", ":q<cr>", { desc = "quit current window" })
-- vim.keymap.set("n", "<leader>s", ":wqa<cr>")
vim.keymap.set("n", "<leader>s", ":edit #<cr>")
vim.keymap.set("n", "<leader>S", ":vert sfind #<cr>")

vim.keymap.set("i", "jk", "<esc>")

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y<cr>')

vim.keymap.set({ "n", "v" }, "S", "^")
vim.keymap.set({ "n", "v" }, "E", "$")

require("oil").setup({
	keymaps = {
		["<leader>c"] = { "actions.close", mode = "n" }
	},
	view_options = {
		show_hidden = true
	},
	float = {
		border = "rounded",
		max_width = math.floor(0.75 * vim.o.columns),
		max_height = math.floor(0.75 * vim.o.lines),
		win_options = {
			winblend = 0
		}
	},
	confirmation = {
		border = "rounded",
		win_options = {
			winblend = 0
		}
	},
	progress = {
		border = "rounded",
		win_options = {
			winblend = 0
		}
	},
	ssh = {
		border = "rounded"
	},
	keymaps_help = {
		border = "rounded"
	}
})

vim.keymap.set("n", "<leader>e", ":Oil<cr>")
vim.keymap.set("n", "-", require("oil").open_float)

require("mini.ai").setup()
require("mini.comment").setup()
require("mini.move").setup()
require("mini.pairs").setup()
require("mini.surround").setup()

require("mini.pick").setup({
	window = {
		config = {
			border = "rounded",
			anchor = "NW",
			width = math.floor(0.5 * vim.o.columns),
			height = math.floor(0.5 * vim.o.lines)
		},
		prompt_prefix = "> ",
		prompt_caret = " "
	},
	mappings = {
		move_up = "<A-k>",
		move_down = "<A-j>"
	}
})

-- vim.keymap.set("n", "<leader>f", ":Pick files<cr>")
vim.keymap.set("n", "<leader>f", function()
	require("mini.pick").builtin.files({}, {
		source = {
			show = function(buf_id, items, query)
				return MiniPick.default_show(buf_id, items, query, { show_icons = false })
			end
		}
	})
end)

-- vim.keymap.set("n", "<leader>h", ":Pick help<cr>")
vim.keymap.set("n", "<leader>h", function()
	require("mini.pick").builtin.help({ default_split = "vertical" }, {})
end)

vim.cmd("colorscheme base16-grayscale-dark")
-- vim.cmd("colorscheme base16-grayscale-light")

-- vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "Normal" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "Normal" })
vim.api.nvim_set_hl(0, "BlinkCmpKind", { link = "Normal" })

require("neocodeium").setup({ silent = true })

vim.keymap.set("i", "<A-f>", function() require("neocodeium").accept() end, { desc = "accept suggestion" })
vim.keymap.set("i", "<A-e>", function() require("neocodeium").cycle_or_complete() end, { desc = "next suggestion" })
vim.keymap.set("i", "<A-r>", function() require("neocodeium").cycle_or_complete(-1) end, { desc = "previous suggestion" })
vim.keymap.set("i", "<A-c>", function() require("neocodeium").clear() end, { desc = "clear suggestion" })

-- enable neocodeium completion in the current buffer:
vim.keymap.set("n", "<leader>n", function() require("neocodeium").enable_buffer() end,
	{ desc = "enable neocodeium in current buffer" })

-- disable neocodeium completion in the current buffer:
vim.keymap.set("n", "<leader>ns", function() require("neocodeium").disable_buffer() end,
	{ desc = "disable neocodeium in current buffer" })

-- open windsurf chat:
vim.keymap.set("n", "<leader>nc", function() require("neocodeium").chat() end, { desc = "open windsurf chat" })


require("typst-preview").setup({
	open_cmd = "qutebrowser %s",
	port = 8080
})

vim.keymap.set("n", "<leader>tp", ":TypstPreview<cr>", { desc = "start typst preview" })
vim.keymap.set("n", "<leader>tps", ":TypstPreviewStop<cr>", { desc = "stop typst preview" })

vim.keymap.set("n", "<leader>lg", ":LazyGit<cr>", { desc = "open lazygit" })

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = {
					"vim",
					"require"
				}
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true)
			},
			telemetry = {
				enable = false
			}
		}
	}
})

-- vim.lsp.enable({ "lua_ls", "tinymist", "gopls", "clangd" })

-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(args)
-- 		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
-- 		if client:supports_method("textDocument/completion") then
-- 			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
-- 		end
-- 	end
-- })

-- vim.cmd("set completeopt+=noselect")

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "format current buffer" })
