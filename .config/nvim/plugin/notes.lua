vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/obsidian-nvim/obsidian.nvim"
})

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
  legacy_commands = false,
  checkbox = {
    -- Cycle by frequency of use: todo -> done, then the rarer states.
    order = { " ", "x", ">", "~", "!" },
  },
  footer = {
    enabled = false,
  },
})

-- Helpers
local floats = {}

local function float_config(title)
  local avail_height = vim.o.lines - vim.o.cmdheight - 2
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(avail_height * 0.9)

  return {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((avail_height - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
    title = title or " Float ",
    title_pos = "center",
  }
end

local function toggle_command_float(name, command, title)
  local state = floats[name] or {}
  floats[name] = state

  -- Hide the existing float.
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    state.cursor = vim.api.nvim_win_get_cursor(state.win)
    vim.api.nvim_win_hide(state.win)
    state.win = nil
    return
  end

  -- Close any other open float so they replace each other instead of stacking.
  for other_name, other in pairs(floats) do
    if other_name ~= name and other.win and vim.api.nvim_win_is_valid(other.win) then
      other.cursor = vim.api.nvim_win_get_cursor(other.win)
      vim.api.nvim_win_hide(other.win)
      other.win = nil
    end
  end

  -- Reopen the existing buffer.
  if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
    state.win = vim.api.nvim_open_win(
      state.buf,
      true,
      float_config(title)
    )

    if state.cursor then
      pcall(vim.api.nvim_win_set_cursor, state.win, state.cursor)
    end

    return
  end

  -- First opening: create a float, then run the command inside it.
  local scratch = vim.api.nvim_create_buf(false, true)

  state.win = vim.api.nvim_open_win(
    scratch,
    true,
    float_config(title)
  )

  vim.cmd(command)

  state.buf = vim.api.nvim_get_current_buf()
  vim.bo[state.buf].bufhidden = "hide"
end

local function float_mapping(lhs, name, command, title, desc)
  vim.keymap.set("n", lhs, function()
    toggle_command_float(name, command, title)
  end, { desc = desc })
end

-- Keymaps
float_mapping(
  "<leader>oy",
  "yesterday",
  "Obsidian yesterday",
  " Yesterday ",
  "Toggle yesterday's daily note"
)

float_mapping(
  "<leader>od",
  "today",
  "Obsidian today",
  " Today ",
  "Toggle today's daily note"
)

float_mapping(
  "<leader>ot",
  "tomorrow",
  "Obsidian tomorrow",
  " Tomorrow ",
  "Toggle tomorrow's daily note"
)

-- Find a note by its name/path.
vim.keymap.set(
  "n",
  "<leader>of",
  "<cmd>Obsidian quick_switch<CR>",
  { desc = "Find Obsidian note" }
)

-- Search inside all notes.
vim.keymap.set(
  "n",
  "<leader>os",
  "<cmd>Obsidian search<CR>",
  { desc = "Search Obsidian notes" }
)
