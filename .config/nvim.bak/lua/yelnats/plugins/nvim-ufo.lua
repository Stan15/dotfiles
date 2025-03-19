return {
	"kevinhwang91/nvim-ufo",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"kevinhwang91/promise-async",
	},
	config = function()
		vim.o.foldcolumn = "1"
		vim.o.foldlevel = 99
		vim.foldlevelstart = 99
		vim.o.foldenable = true
	end,
}
