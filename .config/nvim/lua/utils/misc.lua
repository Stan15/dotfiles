local M = {}

M.obj_to_str = function(obj)
  local dump
  dump = function(o, indent)
    indent = indent or 0
    local spacing = string.rep("  ", indent)

    if type(o) == "table" then
      local s = "{\n"
      for k, v in pairs(o) do
        local key = type(k) == "string" and string.format('["%s"]', k) or string.format("[%s]", tostring(k))
        s = s .. spacing .. "  " .. key .. " = " .. dump(v, indent + 1) .. ",\n"
      end
      return s .. spacing .. "}"
    else
      return tostring(o)
    end
  end
  return dump(obj, 0)
end

return M
