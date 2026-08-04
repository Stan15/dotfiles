-- Autosave
vim.pack.add({
  "https://github.com/okuuva/auto-save.nvim",
})
require("auto-save").setup()

-- Undo history
vim.keymap.set("n", "<leader>u", function()
  vim.cmd.packadd("nvim.undotree")
  vim.cmd.Undotree()
end, {
  desc = "Toggle undo tree",
})
