return {
  "nvim-telescope/telescope-ui-select.nvim",
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_cursor({})
        }
      }
    })

    telescope.load_extension("ui-select")
  end
}
