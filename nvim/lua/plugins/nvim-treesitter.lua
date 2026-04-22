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

local has_cli = vim.fn.executable("tree-sitter") == 1
	and (vim.fn.system({ "tree-sitter", "--version" }) and vim.v.shell_error == 0)

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	cond = not vim.g.vscode,
	build = has_cli and ":TSUpdate" or nil,
	config = function()
		if has_cli then
			require("nvim-treesitter").install(parsers)
		end

		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			callback = function()
				pcall(vim.treesitter.start)
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
