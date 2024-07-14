function escape_literal_for_regex(text)
	local magic_chars = "().%+-*?[^$"
	return text:gsub("[" .. magic_chars:gsub(".", "%%%1") .. "]", "%%%1")
end

return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
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
				local blacklisted_repos = { "zymewire/zymewire-rails-app.git" }

				local current_repo_url = vim.api.nvim_exec("git config --get remote.origin.url", true)
        for repo_name in blacklisted_repos do
          if string.find(current_repo_url, repo_name) then
            return nil
          end
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
