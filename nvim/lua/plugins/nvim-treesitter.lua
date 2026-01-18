return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	cond = not vim.g.vscode,
	config = function()
		require("nvim-treesitter.configs").setup({
			indent = {
				enable = true,
			},
			ensure_installed = {
				"c",
				"cpp",
				"python",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
			},
			auto_install = true,
			highlight = {
				enable = true,
			},
		})
	end,
}
