return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = function()
		vim.cmd([[Lazy load markdown-preview.nvim]])
		vim.fn["mkdp#util#install"]()
	end,
	config = function()
		vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>")
	end,
}
