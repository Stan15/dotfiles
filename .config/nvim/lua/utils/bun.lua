local M = {}

M.is_using_bun = function(path)
  local package_json = path .. "/package.json"
  local file = io.open(package_json, "r")
  if not file then return false end

  local content = file:read("*a")
  file:close()

  -- Check if there's a "bun" field or if "bun" appears in scripts
  if content:match('"bun"%s*:') or content:match('"scripts"%s*:%s*{[^}]*bun') then
    return true
  end

  -- Also check for a bun.lockb file
  local bun_lock = io.open(path .. "/bun.lockb", "r")
  if bun_lock then
    bun_lock:close()
    return true
  end

  return false
end

M.get_bun_path = function()
  local is_windows = vim.fn.has("win32") or vim.fn.has("win64")
  local cmd = is_windows and "where bun" or "command -v bun"

  local handle = io.popen(cmd)
  if not handle then return nil end

  local result = handle:read("*a")
  handle:close()

  -- handle line endings / whitespace
  local path = result:gsub("[\r\n]+", ""):gsub("^%s+", ""):gsub("%s+$", "")
  return path ~= "" and path or nil
end

return M
