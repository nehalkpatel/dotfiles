return {
	"folke/lazydev.nvim",
	cond = not vim.g.vscode,
	ft = "lua",
	opts = {
		library = {
			-- Load luvit types when `vim.uv` is found
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	},
}
