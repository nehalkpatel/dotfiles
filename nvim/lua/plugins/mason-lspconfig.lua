return {
	"williamboman/mason-lspconfig.nvim",
	cond = not vim.g.vscode,
	opts = {
		ensure_installed = {
			"lua_ls",
			"pyright",
			"clangd",
		},
		automatic_installation = true,
	},
	event = "BufReadPre",
	dependencies = "williamboman/mason.nvim",
}
