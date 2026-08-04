vim.pack.add({
  "https://github.com/folke/snacks.nvim"
})

require("snacks").setup({
  image = {
    enabled = true,
    doc = {
      enabled = true,
      inline = false,
      float = true,
    },
    convert = {
      notify = true,    -- default is false; turn on until mmdc is proven working
      mermaid = function()
        local theme = vim.o.background == "light" and "neutral" or "dark"
        return { "-i", "{src}", "-o", "{file}", "-b", "transparent", "-t", theme, "-s", "{scale}" }
      end,
    },
  },
  keys = {
    { "<leader>ii", function() Snacks.image.hover() end, desc = "Image hover" },
  },
})
