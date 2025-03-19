return {
	"folke/zen-mode.nvim",
	dependencies = {
		"folke/twilight.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>")
	end,
}
