-- vim.g.netrw_liststyle = 3

local opt = vim.opt

if not vim.env.SSH_TTY then
  -- only set clipboard if not in ssh, to make sure the OSC 52
  -- integration works automatically. Requires Neovim >= 0.10.0
  opt.clipboard = "unnamedplus"
end

opt.relativenumber = true
opt.number = true
opt.scrolloff = 10

-- tabs and indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false
opt.ignorecase = true
opt.smartcase = true

-- appearance
opt.termguicolors = true
opt.signcolumn = "auto"

-- split windows
opt.splitright = true
opt.splitbelow = true
