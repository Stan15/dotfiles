-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<cmd>lua require('tmux').move_left()<cr>", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<cmd>lua require('tmux').move_bottom()<cr>", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<cmd>lua require('tmux').move_top()<cr>", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<cmd>lua require('tmux').move_right()<cr>", { desc = "Go to Right Window", remap = true })
