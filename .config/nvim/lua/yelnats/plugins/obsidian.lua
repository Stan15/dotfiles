return {
	"Stan15/obsidian.nvim",
	version = "*",
	-- lazy = true,
	-- ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("obsidian").setup({
			workspaces = {
				{
					name = "work",
					path = "~/vaults/work",
				},
				{
					name = "personal",
					path = "~/vaults/personal",
				},
			},
			daily_notes = {
				folder = "notes/dailies",
			},
			mappings = {
				["<cr>"] = {
					action = function()
						return require("obsidian").util.smart_action()
					end,
					opts = { buffer = true, expr = true },
				},
			},
      open_notes_in = "float",
		})

		vim.keymap.set("n", "<leader>ow", "<cmd>ObsidianWorkspace<cr>")
		vim.keymap.set("n", "<leader>of", "<cmd>ObsidianSearch<cr>")
		vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<cr>")
		vim.keymap.set({ "n", "v" }, "<leader>ox", "<cmd>ObsidianExtractNote<cr>")
		vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianToday<cr>")
		vim.keymap.set("n", "<leader>oy", "<cmd>ObsidianYesterday<cr>")
	end,
}
