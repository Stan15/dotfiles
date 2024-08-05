return {
	"prichrd/refgo.nvim",

	config = function()
		vim.keymap.set("n", "<leader>rc", function()
			vim.cmd("RefCopy")
			local reference = vim.fn.getreg('"') -- Get the reference from the default register
			vim.fn.setreg("+", reference) -- Copy the reference to the system clipboard
			print("Copied line reference to clipboard!")
		end, { noremap = true, silent = true })
		vim.keymap.set(
			"n",
			"<leader>rg",
			":RefGo<CR>",
			{ noremap = true, silent = true, desc = "Go to reference to the current line" }
		)
	end,
}
