return {
	"Shatur/neovim-session-manager",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local Path = require("plenary.path")
		local config = require("session_manager.config")
		require("session_manager").setup({})
	end,
}
