local repo_blacklist = { "zymewire/zymewire-rails-app" }
local filetype_blacklist = { "" }

function escape_string_for_regex(text)
	local magic_chars = "().%+-*?[^$"
	return text:gsub("[" .. magic_chars:gsub(".", "%%%1") .. "]", "%%%1")
end

function is_current_repo_in_blacklist(blacklist)
	local current_repo_url = vim.fn.system("git config --get remote.origin.url")
	for _, repo_name in pairs(blacklist) do
		if string.match(current_repo_url, escape_string_for_regex(repo_name)) then
			return true
		end
	end
	return false
end

return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"pocco81/auto-save.nvim",
	},
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
			},
			format_on_save = function()
				if is_current_repo_in_blacklist(repo_blacklist) then
					return nil
				end
				return {
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				}
			end,
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
