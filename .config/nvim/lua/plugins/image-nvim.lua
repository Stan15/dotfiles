return {
  "3rd/image.nvim",
  build = false,
  opts = {
    processor = "magick_cli",
  },
  config = function(_, opts)
    require("image").setup(opts)
    vim.keymap.set("n", "<leader>i", "<cmd>Image<cr>", { desc = "Image" })
  end,
}
