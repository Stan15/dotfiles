-- Finder
vim.pack.add({
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/ibhagwan/fzf-lua",
})
local fzf = require("fzf-lua")
fzf.setup({"ivy"})

vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Grep in project" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Find open buffers" })
vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "Search help tags" })
vim.keymap.set("n", "<leader>fk", fzf.keymaps, { desc = "Search keymaps" })
vim.keymap.set("n", "<leader>fr", fzf.resume, { desc = "Resume last picker" })
