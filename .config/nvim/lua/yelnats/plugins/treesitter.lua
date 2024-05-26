-- TODO: :InspectTree doesn't work
return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
      ensure_installed = {
        "json", "javascript", "python", "typescript", "tsx", "markdown", "markdown_inline", "gitignore", "ruby", "lua", "html", "css", "dockerfile"
      },
    })
  end,
}
