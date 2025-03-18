return {
	"mfussenegger/nvim-dap",
	dependencies = {
    "suketa/nvim-dap-ruby"
  },
	config = function()
		local dap = require("dap")

    vim.keymap.set("n", "<leader>c", function() dap.continue() end, { desc = "Debug continue" })
    vim.keymap.set("n", "<leader>j", function() dap.step_over() end, { desc = "Debug step over" })
    vim.keymap.set("n", "<leader>dl", function() dap.step_into() end, { desc = "Debug step into" })
    vim.keymap.set("n", "<leader>k", function() dap.step_out() end, { desc = "Debug step out" })

    vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end, { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<leader>cb", function() dap.set_breakpoint(vim.fn.input("Condition: ")) end, { desc = "Conditional breakpoint" })
    vim.keymap.set("n", "<leader>B", function() dap.set_breakpoint() end, { desc = "Set breakpoint" })
    -- vim.keymap.set("n", "<leader>lp", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, { desc = "Set logpoint" })
    vim.keymap.set("n", "<leader>dr", function() dap.repl.open() end, { desc = "Open debug REPL" })
    -- vim.keymap.set("n", "<Leader>dl", function() dap.run_last() end)
    vim.keymap.set({"n", "v"}, "<Leader>dh", function()
      require("dap.ui.widgets").hover()
    end, { desc = "Debug hover" })
    vim.keymap.set({"n", "v"}, "<Leader>dp", function()
      require("dap.ui.widgets").preview()
    end, { desc = "Debug preview" })
    vim.keymap.set("n", "<Leader>df", function()
      local widgets = require("dap.ui.widgets")
      widgets.centered_float(widgets.frames)
    end, { desc = "Debug frames" })
    vim.keymap.set("n", "<Leader>ds", function()
      local widgets = require("dap.ui.widgets")
      widgets.centered_float(widgets.scopes)
    end, { desc = "Debug scopes" })
	end,
}
