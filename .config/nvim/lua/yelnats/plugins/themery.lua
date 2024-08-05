function get_material_themes()
  local theme_names = []
	return {
		name = "",
		colorscheme = "material",
		before = [[

    ]],
	}
end

return {
	"zaldih/themery.nvim",
	config = function()
		local themes = {
			"tokyonight",
			get_material_themes(),
		}
		require("themery").setup({
			themes = themes,
			livePreview = true,
		})
	end,
}
