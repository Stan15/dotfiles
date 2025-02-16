return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
	},
	config = function()
		local dapui = require("dapui")
    dapui.setup()

		vim.keymap.set({ "n", "v" }, "<leader>d?", dapui.eval, { desc = "Evaluate selected expression" })
    vim.keymap.set({ "n", "v" }, "<leader>dr", function() dapui.open({ reset = true}) end)

		local dap = require("dap")
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- TODO: Customize properly
		local sign = vim.fn.sign_define
		sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
		sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
		sign("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
	end,
}
