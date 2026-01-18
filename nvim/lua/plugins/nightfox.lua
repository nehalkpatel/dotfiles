return {
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 999,
	cond = not vim.g.vscode,
	config = function()
		vim.cmd("colorscheme nightfox")
	end,
}
