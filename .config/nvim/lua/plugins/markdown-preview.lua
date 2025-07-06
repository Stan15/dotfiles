return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  -- install without yarn or npm (not working, idk why)
  -- build = function()
  --   vim.fn["mkdp#util#install"]()
  -- end,
  build = "cd app && yarn install",
  config = function()
    vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>")
    vim.g.mkdp_auto_close = 0
  end,
}
