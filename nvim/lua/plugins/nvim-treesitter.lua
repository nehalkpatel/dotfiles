local parsers = {
	"c",
	"cpp",
	"python",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"markdown",
	"markdown_inline",
}

-- Filetypes to start treesitter on. Differs from `parsers` where the parser
-- name doesn't match the filetype (vimdoc→help) or isn't used standalone
-- (markdown_inline is an injection only).
local filetypes = {
	"c",
	"cpp",
	"python",
	"lua",
	"vim",
	"help",
	"query",
	"markdown",
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	cond = not vim.g.vscode,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			callback = function()
				vim.treesitter.start()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
