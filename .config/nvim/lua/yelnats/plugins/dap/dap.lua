return {
	"mfussenegger/nvim-dap",
	dependencies = {
    -- "suketa/nvim-dap-ruby"
  },
	config = function()
		local dap = require("dap")
    dap.adapters.ruby = function(callback, config)
      callback {
        type = "server",
        host = "localhost",
        port = "3002",
        executable = {
          command = "bundle",
          args = { "exec", "rdbg", "-n", "--open", "--port", "3002",
            "-c", "--", "bundle", "exec", "rails", "s",
          },
        },
      }
    end

    dap.configurations.ruby = {
      {
        type = "ruby",
        name = "debug current file",
        request = "attach",
        localfs = true,
        command = "ruby",
        script = "${file}",
      },
      {
        type = "ruby",
        name = "run current spec file",
        request = "attach",
        localfs = true,
        command = "rspec",
        script = "${file}",
      },
    }

    vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "Debug continue" })
    vim.keymap.set("n", "<leader>dj", function() dap.step_over() end, { desc = "Debug step over" })
    vim.keymap.set("n", "<leader>dl", function() dap.step_into() end, { desc = "Debug step into" })
    vim.keymap.set("n", "<leader>dk", function() dap.step_out() end, { desc = "Debug step out" })

    vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end, { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<leader>B", function() dap.set_breakpoint() end, { desc = "Set breakpoint" })
    vim.keymap.set("n", "<leader>lp", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, { desc = "Set logpoint" })
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
