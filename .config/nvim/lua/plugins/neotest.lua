return {
  { "olimorris/neotest-rspec" },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
    },
    opts = { adapters = { "neotest-rspec" } },
  },
}
