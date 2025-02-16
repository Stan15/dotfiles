return {
	"mfussenegger/nvim-dap",
	config = function()
		local dap = require("dap")

		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug continue" })
	end,
}
