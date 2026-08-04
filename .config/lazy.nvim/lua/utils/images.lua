local M = {}

-- Private helper functions
local function get_image_path()
  local line = vim.api.nvim_get_current_line()
  -- Pattern to match image path in Markdown syntax ![alt](path)
  local image_pattern = "%[.-%]%((.-)%)"
  local _, _, image_path = string.find(line, image_pattern)
  return image_path
end

local function clean_image_path(image_path)
  if not image_path then
    return nil
  end
  -- URL decode the path (convert %20 to spaces, etc.)
  image_path = image_path:gsub("%%(%x%x)", function(hex)
    return string.char(tonumber(hex, 16))
  end)
  -- Remove backslash escapes (convert "\ " to " ")
  image_path = image_path:gsub("\\(.)", "%1")
  return image_path
end

local function make_absolute_path(image_path)
  if vim.startswith(image_path, "/") then
    return image_path
  else
    -- Convert relative path to absolute using current file's directory
    local current_file_path = vim.fn.expand("%:p:h")
    return current_file_path .. "/" .. image_path
  end
end

local function is_url(path)
  return string.sub(path, 1, 4) == "http"
end

M.open = function()
  local image_path = get_image_path()
  local cleaned_path = clean_image_path(image_path)

  if not cleaned_path then
    print("No image found under the cursor")
    return
  end

  if is_url(cleaned_path) then
    print("URL image, use 'gx' to open it in the default browser.")
    return
  end

  local absolute_image_path = make_absolute_path(cleaned_path)

  local command = { "open", "-a", "Preview", absolute_image_path }
  local result = vim.fn.system(command)
  local exit_code = vim.v.shell_error

  if exit_code == 0 then
    print("Opened image in Preview: " .. absolute_image_path)
  else
    print("Failed to open image in Preview. Error: " .. result)
    print("Exit code: " .. exit_code)
    print("Path: " .. absolute_image_path)
  end
end

M.open_in_finder = function()
  local image_path = get_image_path()
  local cleaned_path = clean_image_path(image_path)

  if not cleaned_path then
    print("No image found under the cursor")
    return
  end

  if is_url(cleaned_path) then
    print("URL image, use 'gx' to open it in the default browser.")
    return
  end

  local absolute_image_path = make_absolute_path(cleaned_path)

  -- Open the containing folder in Finder and select the image file
  local command = { "open", "-R", absolute_image_path }
  local result = vim.fn.system(command)
  local exit_code = vim.v.shell_error

  if exit_code == 0 then
    print("Opened image in Finder: " .. absolute_image_path)
  else
    print("Failed to open image in Finder. Error: " .. result)
    print("Exit code: " .. exit_code)
    print("Path: " .. absolute_image_path)
  end
end

M.delete_file = function()
  local image_path = get_image_path()
  local cleaned_path = clean_image_path(image_path)

  if not cleaned_path then
    vim.api.nvim_echo({ { "No image found under the cursor", "WarningMsg" } }, false, {})
    return
  end

  if is_url(cleaned_path) then
    vim.api.nvim_echo({ { "URL image cannot be deleted from disk.", "WarningMsg" } }, false, {})
    return
  end

  local absolute_image_path = make_absolute_path(cleaned_path)

  if vim.fn.filereadable(absolute_image_path) == 0 then
    vim.api.nvim_echo(
      { { "Image file does not exist:\n", "ErrorMsg" }, { absolute_image_path, "ErrorMsg" } },
      false,
      {}
    )
    return
  end

  if vim.fn.executable("trash") == 0 then
    vim.api.nvim_echo({
      { "- Trash utility not installed. Make sure to install it first\n", "ErrorMsg" },
      { "- In macOS run `brew install trash`\n", nil },
    }, false, {})
    return
  end

  -- Move cursor to top so popup is visible (cursor is normally on top of image name)
  local current_pos = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_win_set_cursor(0, { 1, 0 })

  vim.ui.select({ "yes", "no" }, { prompt = "Delete image file? " }, function(choice)
    vim.api.nvim_win_set_cursor(0, current_pos)

    if choice == "yes" then
      local success, _ = pcall(function()
        vim.fn.system({ "trash", absolute_image_path })
      end)

      if success and vim.fn.filereadable(absolute_image_path) == 1 then
        -- Trash deletion failed, try rm as fallback
        current_pos = vim.api.nvim_win_get_cursor(0)
        vim.api.nvim_win_set_cursor(0, { 1, 0 })

        vim.ui.select({ "yes", "no" }, { prompt = "Trash deletion failed. Try with rm command? " }, function(rm_choice)
          vim.api.nvim_win_set_cursor(0, current_pos)

          if rm_choice == "yes" then
            local rm_success, _ = pcall(function()
              vim.fn.system({ "rm", absolute_image_path })
            end)

            if rm_success and vim.fn.filereadable(absolute_image_path) == 0 then
              vim.api.nvim_echo({
                { "Image file deleted from disk using rm:\n", "Normal" },
                { absolute_image_path, "Normal" },
              }, false, {})
              vim.cmd("edit!")
              vim.cmd("normal! dd")
            else
              vim.api.nvim_echo({
                { "Failed to delete image file with rm:\n", "ErrorMsg" },
                { absolute_image_path, "ErrorMsg" },
              }, false, {})
            end
          end
        end)
      elseif success and vim.fn.filereadable(absolute_image_path) == 0 then
        vim.api.nvim_echo({
          { "Image file deleted from disk:\n", "Normal" },
          { absolute_image_path, "Normal" },
        }, false, {})
        vim.cmd("edit!")
        vim.cmd("normal! dd")
      else
        vim.api.nvim_echo({
          { "Failed to delete image file:\n", "ErrorMsg" },
          { absolute_image_path, "ErrorMsg" },
        }, false, {})
      end
    else
      vim.api.nvim_echo({ { "Image deletion canceled.", "Normal" } }, false, {})
    end
  end)
end

return M

