return {
	"williamboman/mason.nvim",
	cond = not vim.g.vscode,
	cmd = "Mason",
  event = "BufReadPre",
  config = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      },
    }
  },
}
