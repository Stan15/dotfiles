vim.pack.add({
  "https://github.com/stan15/stansutils.nvim",
})

-- Copy paths
local stansutils = require("stansutils")
vim.keymap.set({ "n", "v" }, "<leader>yp", function()
  stansutils.copy_file_reference({ full = false, line = true })
end, { desc = "Copy relative path with line number" })
vim.keymap.set({ "n", "v" }, "<leader>yP", function()
  stansutils.copy_file_reference({ full = true, line = true })
end, { desc = "Copy absolute path with line number" })
