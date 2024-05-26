return {
	"nvimtools/none-ls.nvim", -- linter/formatter handler. creates pseudo-lsp interface for formatters from various languages
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.eslint_d,
				null_ls.builtins.diagnostics.erb_lint,
				null_ls.builtins.diagnostics.rubocop,
				null_ls.builtins.formatting.rubocop,
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Run formatter on current buffer" })
	end,
}
