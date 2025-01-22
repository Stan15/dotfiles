local function open_image(url)
  local uname = vim.os_uname().sysname

  if uname == "Darwin" then
    vim.fn.jobstart({ "qlmanage", "-p", url })
  elseif uname == "Linux" then
    vim.fn.jobstart({ "xdg-open", url })
  elseif uname:match("Windows") then
    vim.vmd(':silent exec "!start ' .. url .. '"')
  else
    print("Unknown OS: " .. uname)
  end
end

return {
	"Stan15/obsidian.nvim",
	version = "*",
	-- lazy = true,
	-- ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
    require("obsidian").setup({
      workspaces = {
        {
          name = "work",
          path = "~/vaults/work",
        },
        {
          name = "personal",
          path = "~/vaults/personal",
        },
      },
      daily_notes = {
        folder = "notes/dailies",
      },
      mappings = {
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },
      open_notes_in = "float",
      follow_url_func = function(url)
        vim.ui.open(url)
      end,
      follow_img_func = open_image
    })

    vim.keymap.set("n", "<leader>ow", "<cmd>ObsidianWorkspace<cr>")
    vim.keymap.set("n", "<leader>of", "<cmd>ObsidianSearch<cr>")
    vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<cr>")
    vim.keymap.set({ "n", "v" }, "<leader>ox", "<cmd>ObsidianExtractNote<cr>")
    vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianToday<cr>")
    vim.keymap.set("n", "<leader>oy", "<cmd>ObsidianYesterday<cr>")
	end,
}
