vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
keymap.set({ "n", "v" }, "<leader>y", '"+y', { noremap = true, desc = "Copy to system clipboard" })
keymap.set({ "n", "v" }, "<leader>p", '"+p', { noremap = true, desc = "Paste from system clipboard" })

-- tab management
keymap.set("n", "<leader>t+", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>t-", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })
