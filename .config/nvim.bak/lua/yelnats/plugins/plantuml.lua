return {
	"https://gitlab.com/itaranto/plantuml.nvim",
	version = "*",
	config = function()
		require("plantuml").setup({
			type = "image",
			options = {
				prog = "feh",
				dark_mode = "true",
				format = nil,
			},
		})
	end,
}
