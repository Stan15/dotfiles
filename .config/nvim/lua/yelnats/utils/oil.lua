local oil = require("oil")
local default_override = false

local function enable_file_detail_view_toggle(plugin_config, opts)
  opts = opts or {}
  if opts.override == nil then
    opts.override = default_override
  end

  local keymap = opts.keymap or "gd"

  if not opts.override and plugin_config.keymaps ~= nil and plugin_config.keymaps["gd"] ~= nil then
    error("Cannot configure oil.nvim file detail view toggle keymap to " .. keymap .. ". Keymap is already taken.")
  end

  local detail = false
  plugin_config.keymaps = plugin_config.keymaps or {}
  plugin_config.keymaps["gd"] = {
    desc = "Toggle file detail view",
    callback = function()
      detail = not detail
      if detail then
        oil.set_columns({ "permissions", "size", "mtime", "icon" })
      else
        oil.set_columns({ "icon" })
      end
    end,
  }
end

local function show_cwd(plugin_config, opts)
  opts = opts or {}
  if opts.override == nil then
    opts.override = default_override
  end

  if not opts.override and plugin_config.win_options ~= nil and plugin_config.win_options.winbar ~= nil then
    error("Cannot configure oil.nvim 'show_cwd_in_winbar'. winbar is already configured.")
  end

  plugin_config.win_options = plugin_config.win_options or {}
  function _G.get_oil_cwd_display()
    local winid = vim.g.statusline_winid
    local win_config = vim.api.nvim_win_get_config(winid)

    -- If the window is floating, remove the winbar (floating window already displays file path)
    if win_config.relative ~= "" then
      vim.schedule(function()
        vim.wo[winid].winbar = nil
      end)
       return ""
    end

    local bufnr = vim.api.nvim_win_get_buf(winid)
    local dir = oil.get_current_dir(bufnr)
    if dir then
      return vim.fn.fnamemodify(dir, ":~")
    else
      -- If there's no current directory (e.g. over ssh), just show the buffer name
      local bufname vim.api.nvim_buf_get_name(bufnr)
      return bufname ~= "" and bufname or nil
    end
  end
  plugin_config.win_options.winbar = "%!v:lua.get_oil_cwd_display()"
end

-- helper function to parse output
local function parse_output(proc)
  local result = proc:wait()
  local ret = {}
  if result.code == 0 then
    for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
      -- Remove trailing slash
      line = line:gsub("/$", "")
      ret[line] = true
    end
  end
  return ret
end

-- build git status
local function new_git_status()
  return setmetatable({}, {
    __index = function(self, key)
      local ignore_proc = vim.system(
        { "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" },
        { cwd = key, text = true }
      )

      local tracked_proc = vim.system(
        { "git", "ls-tree", "HEAD", "--name-only" },
        { cwd = key, text = true }
      )
      local ret = {
        ignored = parse_output(ignore_proc),
        tracked = parse_output(tracked_proc),
      }

      rawset(self, key, ret)
      return ret
    end
  })
end

local git_status = new_git_status()

-- Clear git status cache on refresh
local refresh = require("oil.actions").refresh
local orig_refresh = refresh.callback
refresh.callback = function(...)
  git_status = new_git_status()
  orig_refresh(...)
end

local function hide_gitignored_show_git_tracked_hidden_files(plugin_config, opts)
  opts = opts or {}
  if opts.override == nil then
    opts.override = default_override
  end

  if not opts.override and plugin_config.view_options ~= nil and plugin_config.is_hidden_file.winbar ~= nil then
    error("Cannot configure oil.nvim 'hide gitignored and show git tracked hidden files'. hidden file behaviour has already been configured.")
  end

  plugin_config.view_options = plugin_config.view_options or {}
  plugin_config.view_options.is_hidden_file = function(name, bufnr)
    local dir = oil.get_current_dir(bufnr)
    local is_dotfile = vim.startswith(name, ".") and name ~= ".."
    -- if no local directory (e.g. for ssh connections), just hide dotfiles
    if not dir then
      return is_dotfile
    end
    -- dotfiles are considered hidden unless tracked
    if is_dotfile then
      return git_status[dir].tracked[name]
    else
      -- check if file is gitignored
      return git_status[dir].ignored[name]
    end
  end
end



return {
  enable_file_detail_view_toggle = enable_file_detail_view_toggle,
  show_cwd = show_cwd,
  hide_gitignored_show_git_tracked_hidden_files = hide_gitignored_show_git_tracked_hidden_files,
}
