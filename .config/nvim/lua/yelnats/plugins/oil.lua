return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = {
    { "echasnovski/mini.icons", opts = {} },
  },
  config = function ()
    local oil = require("oil")
    oil.setup({
      default_file_explorer = false,
    })

    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end
}
