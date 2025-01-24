return {
  "stevearc/oil.nvim",
  dependencies = {
    { "echasnovski/mini.icons", opts = {} },
  },
  config = function ()
    local oil = require("oil")
    local utils = require("yelnats.utils.oil")

    local plugin_config = {
      default_file_explorer = true,
    }
    utils.enable_file_detail_view_toggle(plugin_config)
    utils.show_cwd(plugin_config)
    utils.hide_gitignored_show_git_tracked_hidden_files(plugin_config)

    oil.setup(plugin_config)

    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set("n", "<space>-", oil.toggle_float)
  end
}
