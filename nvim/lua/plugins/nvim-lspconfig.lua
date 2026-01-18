local diagnostic_signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = "" }

local on_attach = function(client, bufnr)
	local map = function(keys, func, desc)
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	-- LSP navigation
	map("<leader>fd", "<cmd>Lspsaga finder<cr>", "LSP finder")
	map("<leader>gd", "<cmd>Lspsaga peek_definition<cr>", "Peek definition")
	map("<leader>gD", "<cmd>Lspsaga goto_definition<cr>", "Go to definition")
	map("<leader>gr", "<cmd>Lspsaga finder ref<cr>", "Find references")

	-- LSP actions
	map("<leader>ca", "<cmd>Lspsaga code_action<cr>", "Code action")
	map("<leader>rn", "<cmd>Lspsaga rename<cr>", "Rename symbol")
	map("K", "<cmd>Lspsaga hover_doc<cr>", "Hover documentation")

	-- Diagnostics
	map("<leader>D", "<cmd>Lspsaga show_line_diagnostics<cr>", "Line diagnostics")
	map("<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<cr>", "Cursor diagnostics")
	map("[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Previous diagnostic")
	map("]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", "Next diagnostic")

	-- Format with conform (if available)
	map("<leader>lf", function()
		require("conform").format({ bufnr = bufnr })
	end, "Format buffer")

	-- Python-specific
	if client.name == "pyright" then
		map("<leader>oi", "<cmd>PyrightOrganizeImports<cr>", "Organize imports")
	end
end

local config = function()
	local lspconfig = require("lspconfig")
	local cmp_nvim_lsp = require("cmp_nvim_lsp")

	-- Set up diagnostic signs
	for type, icon in pairs(diagnostic_signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- Lua (for Neovim config editing)
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
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
	})

	-- Python
	lspconfig.pyright.setup({
		capabilities = capabilities,
		on_attach = on_attach,
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
	})

	-- C/C++
	lspconfig.clangd.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		cmd = {
			"clangd",
			"--offset-encoding=utf-16",
		},
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
