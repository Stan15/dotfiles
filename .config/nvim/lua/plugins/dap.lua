return {
  { "liadoz/nvim-dap-repl-highlights", opts = {} },
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
    opts = {},
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "rcarriga/cmp-dap",
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      opts.sources.providers = opts.sources.providers or {}
      opts.sources.per_filetype = opts.sources.per_filetype or {}

      opts.sources.providers.dap = {
        module = "blink.compat.source",
        enabled = function()
          return vim.bo.buftype ~= "prompt" or require("cmp_dap").is_dap_buffer()
        end,
      }

      local dap_filetypes = { "dap-repl", "dapui_watches", "dapui_hover" }
      for _, filetype in ipairs(dap_filetypes) do
        opts.sources.per_filetype[filetype] = opts.sources.per_filetype[filetype] or {}
        table.insert(opts.sources.per_filetype[filetype], "dap")
      end
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "suketa/nvim-dap-ruby",
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
    },
  },
}
