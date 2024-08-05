return {
	{ "folke/tokyonight.nvim" },
	{
		"marko-cerovac/material.nvim",
		config = function()
			require("material").setup({})
		end,
	},
}
