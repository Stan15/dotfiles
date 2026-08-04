return {
  "pocco81/auto-save.nvim",
  qcmd = "ASToggle", -- optional for lazy loading on command
  event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
  opts = {
    condition = function(buf)
      local utils = require("auto-save.utils.data")

      if
        vim.fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(vim.fn.getbufvar(buf, "&filetype"), { "harpoon" })
      then
        return true -- met condition(s), can save
      end
      return false -- can't save
    end,
  },
}
