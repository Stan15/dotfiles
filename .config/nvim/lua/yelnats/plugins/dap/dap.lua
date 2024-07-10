return {
	"mfussenegger/nvim-dap",
	dependencies = {},
	config = function()
		local dap = require("dap")

		vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug continue" })
	end,
}
