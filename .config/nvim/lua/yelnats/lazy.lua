local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

function plugin_imports()
  
end

require("lazy").setup({
	{ import = "yelnats.plugins" },
	{ import = "yelnats.plugins.lsp" },
	{ import = "yelnats.plugins.dap" },
	{ import = "yelnats.plugins.dap.languages" },
	{ import = "yelnats.plugins.ui" },
	{ import = "yelnats.plugins.ai" },
	{ import = "yelnats.plugins.future-use" },
}, {
	change_detection = {
		notify = false,
	},
})
