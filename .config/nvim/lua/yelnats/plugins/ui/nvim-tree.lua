return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- disable netrw
		vim.g.loaded_netrw = 1
		vim.g.loadednetrwPlugin = 1

		nvimtree.setup({
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			git = {
				ignore = false,
			},
		})

		local keymap = vim.keymap
		-- keymap.set("n", "<leader>tt", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
		-- keymap.set("n", "<leader>tf", "<cmd>NvimTreeFindFile<CR>", { desc = "Find current file in file tree" })
	end,
}
