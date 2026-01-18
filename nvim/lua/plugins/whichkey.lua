return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		delay = 300,
		icons = {
			mappings = false,
		},
		spec = {
			{ "<leader>b", group = "Buffer" },
			{ "<leader>f", group = "Find" },
			{ "<leader>g", group = "Go to" },
			{ "<leader>l", group = "LSP" },
			{ "<leader>w", group = "Window" },
			{ "<leader>c", group = "Code" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer local keymaps",
		},
	},
}
