local diagnostic_signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = "" }

local servers = {
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	},
	pyright = {
		settings = {
			pyright = {
				disableOrganizeImports = false,
				analysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
				},
			},
		},
	},
	clangd = {
		cmd = {
			"clangd",
			"--offset-encoding=utf-16",
		},
	},
}

local config = function()
	for type, icon in pairs(diagnostic_signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	vim.lsp.config("*", {
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
	})

	for name, opts in pairs(servers) do
		vim.lsp.config(name, opts)
	end

	vim.lsp.enable(vim.tbl_keys(servers))

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local bufnr = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)

			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
			end

			map("<leader>fd", "<cmd>Lspsaga finder<cr>", "LSP finder")
			map("<leader>gd", "<cmd>Lspsaga peek_definition<cr>", "Peek definition")
			map("<leader>gD", "<cmd>Lspsaga goto_definition<cr>", "Go to definition")
			map("<leader>gr", "<cmd>Lspsaga finder ref<cr>", "Find references")

			map("<leader>ca", "<cmd>Lspsaga code_action<cr>", "Code action")
			map("<leader>rn", "<cmd>Lspsaga rename<cr>", "Rename symbol")
			map("K", "<cmd>Lspsaga hover_doc<cr>", "Hover documentation")

			map("<leader>D", "<cmd>Lspsaga show_line_diagnostics<cr>", "Line diagnostics")
			map("<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<cr>", "Cursor diagnostics")
			map("[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Previous diagnostic")
			map("]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", "Next diagnostic")

			map("<leader>lf", function()
				require("conform").format({ bufnr = bufnr })
			end, "Format buffer")

			if client and client.name == "pyright" then
				map("<leader>oi", "<cmd>PyrightOrganizeImports<cr>", "Organize imports")
			end
		end,
	})
end

return {
	"neovim/nvim-lspconfig",
	cond = not vim.g.vscode,
	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
	},
}
