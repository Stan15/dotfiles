local function molten_kernel()
  local ok, status = pcall(require, "molten.status")
  if not ok then return "" end
  local kernels = status.kernels()
  if kernels == nil or kernels == "" then return "" end
  return "⚗ " .. kernels
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "franco-ruggeri/codecompanion-lualine.nvim",
  },
  opts = {
    sections = {
      lualine_x = {
        "codecompanion",
        molten_kernel,
      },
    },
  },
}
