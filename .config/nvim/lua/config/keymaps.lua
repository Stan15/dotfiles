-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<cmd>lua require('tmux').move_left()<cr>", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<cmd>lua require('tmux').move_bottom()<cr>", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<cmd>lua require('tmux').move_top()<cr>", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<cmd>lua require('tmux').move_right()<cr>", { desc = "Go to Right Window", remap = true })

-- toggle dap ui (but reset view on open)
map("n", "<leader>dU", "<cmd>lua require('dapui').open({reset=true})<cr>", { desc = "Dap UI (reset)" })

-- project management
map("n", "<leader>mm", function()
  require("linear-nvim").show_assigned_issues()
end)
map({ "n", "v" }, "<leader>mc", function()
  require("linear-nvim").create_issue()
end)
map("n", "<leader>ms", function()
  require("linear-nvim").show_issue_details()
end)
