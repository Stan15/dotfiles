-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Tmux: Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<cmd>lua require('tmux').move_left()<cr>", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<cmd>lua require('tmux').move_bottom()<cr>", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<cmd>lua require('tmux').move_top()<cr>", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<cmd>lua require('tmux').move_right()<cr>", { desc = "Go to Right Window", remap = true })

-- Yank (copy) to system clipboard
map({ "n", "v" }, "<Leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to system clipboard" })
map({ "n" }, "<Leader>Y", '"+Y', { noremap = true, silent = true, desc = "Yank line to system clipboard" })

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

-- images
local image_utils = require("utils.images")
map("n", "<leader>io", image_utils.open, { desc = "[P](macOS) Open image under cursor in Preview" })
map("n", "<leader>if", image_utils.open_in_finder, { desc = "[P](macOS) Open image under cursor in Finder" })
map("n", "<leader>id", image_utils.delete_file, { desc = "[P](macOS) Delete image file under cursor" })

-- utils
local stansutils = require("stansutils")
map({ "n", "v" }, "<leader>yp", function()
  stansutils.copy_file_reference({ full = false, line = true })
end)
map({ "n", "v" }, "<leader>yP", function()
  stansutils.copy_file_reference({ full = true, line = true })
end)

-- rendering
local render_keymap = "<leader>r"
-- markdown-preview
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      render_keymap,
      "<cmd>MarkdownPreviewToggle<cr>",
      { desc = "Render Markdown", noremap = true, silent = true }
    )
  end,
})
-- plantuml-previewer
vim.api.nvim_create_autocmd("FileType", {
  pattern = "plantuml",
  callback = function()
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      render_keymap,
      "<cmd>PlantumlOpen<cr>",
      { desc = "Render PlantUML", noremap = true, silent = true }
    )
  end,
})
