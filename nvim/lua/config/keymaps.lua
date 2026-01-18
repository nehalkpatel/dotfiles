local map = vim.keymap.set

-- Buffer Navigation
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to other buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to other buffer" })

-- Pane and Window Navigation
map("n", "<C-h>", "<C-w>h", { desc = "Navigate left" })
map("n", "<C-j>", "<C-w>j", { desc = "Navigate down" })
map("n", "<C-k>", "<C-w>k", { desc = "Navigate up" })
map("n", "<C-l>", "<C-w>l", { desc = "Navigate right" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Navigate left" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Navigate down" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Navigate up" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Navigate right" })

-- Window Management
map("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Split vertically" })
map("n", "<leader>wh", "<cmd>split<cr>", { desc = "Split horizontally" })
map("n", "<leader>wc", "<cmd>close<cr>", { desc = "Close window" })

-- Indenting (stay in visual mode)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Utility
map("n", "<leader>pa", "<cmd>echo expand('%:p')<cr>", { desc = "Show full file path" })

-- Plugin-dependent keymaps (skip in VSCode)
if not vim.g.vscode then
	-- File Explorer
	map("n", "<leader>m", "<cmd>NvimTreeFocus<cr>", { desc = "Focus file explorer" })
	map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })

	-- Comments (using Comment.nvim's gc operator)
	map("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment" })
	map("v", "<C-/>", "gc", { remap = true, desc = "Toggle comment" })
end
