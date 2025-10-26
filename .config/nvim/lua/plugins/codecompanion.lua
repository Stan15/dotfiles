-- return {}
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- Copilot authentication
    "github/copilot.vim",
    -- Progress options optional
    "j-hui/fidget.nvim",
    "franco-ruggeri/codecompanion-spinner.nvim",
  },
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Chat", mode = { "n", "v" } },
    { "<leader>ap", "<cmd>CodeCompanionActions<cr>", desc = "Prompt Actions", mode = { "n", "v" } },
  },
  config = true,
  opts = {
    log_level = "DEBUG",
    strategies = {
      chat = {
        adapter = "copilot",
      },
      inline = {
        adapter = "copilot",
      },
    },
    adapters = {
      copilot = function()
        local adapters = require("codecompanion.adapters")
        return adapters.extend("copilot", {
          schema = {
            model = {
              default = "claude-3.7-sonnet",
            },
          },
        })
      end,
    },
    extensions = {
      spinner = {},
    },
  },
}
