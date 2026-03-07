local function find_project_root()
  local git_dir = vim.fn.finddir(".git", ".;")
  return git_dir ~= "" and vim.fn.fnamemodify(git_dir, ":h:p") or vim.fn.getcwd()
end

local function find_nearest_venv()
  local active_venv = vim.env.VIRTUAL_ENV
  if active_venv and active_venv ~= "" then
    return active_venv
  end
  local root = find_project_root()
  local venv = vim.fn.finddir(".venv", ".;" .. root)
  return venv ~= "" and vim.fn.fnamemodify(venv, ":p") or nil
end

local function find_best_venv_location_candidate()
  return find_project_root() .. "/.venv"
end

local function pip_cmd(venv_path)
  local uv = vim.fn.exepath("uv")
  if uv ~= "" then
    return uv .. " pip install --python " .. venv_path
  end
  return venv_path .. "/bin/python -m pip install"
end

local function has_ipykernel(venv_path)
  local uv = vim.fn.exepath("uv")
  if uv ~= "" then
    vim.fn.system(uv .. " pip show --python " .. venv_path .. "/bin/python ipykernel 2>/dev/null")
  else
    vim.fn.system(venv_path .. "/bin/python -m pip show ipykernel 2>/dev/null")
  end
  return vim.v.shell_error == 0
end

local function kernel_name(venv_path)
  return vim.fn.fnamemodify(venv_path, ":h:t")
end

local function is_kernel_registered(name)
  local paths = {
    vim.fn.expand("~/.local/share/jupyter/kernels/") .. name,
    vim.fn.expand("~/Library/Jupyter/kernels/") .. name,
    vim.fn.expand("~/AppData/Roaming/jupyter/kernels/") .. name,
  }
  for _, path in ipairs(paths) do
    if vim.fn.isdirectory(path) == 1 then return true end
  end
  return false
end

local function ensure_kernel_registered(venv_path)
  local name = kernel_name(venv_path)
  if is_kernel_registered(name) then
    vim.notify("Using kernel '" .. name .. "'")
    return
  end
  vim.notify("Registering kernel as '" .. name .. "'...")
  vim.fn.jobstart(venv_path .. "/bin/python -m ipykernel install --user --name " .. name, {
    on_exit = function(_, code)
      vim.schedule(function()
        if code == 0 then
          vim.notify("Kernel '" .. name .. "' registered")
        else
          vim.notify("Failed to register kernel", vim.log.levels.ERROR)
        end
      end)
    end,
  })
end

local function do_install_ipykernel(venv_path)
  vim.notify("Installing ipykernel in " .. venv_path .. "...")
  local stderr = {}
  vim.fn.jobstart(pip_cmd(venv_path) .. " ipykernel", {
    stderr_buffered = true,
    on_stderr = function(_, data) stderr = data end,
    on_exit = function(_, code)
      vim.schedule(function()
        if code == 0 then
          vim.notify("ipykernel installed successfully")
          ensure_kernel_registered(venv_path)
        else
          local msg = table.concat(stderr, "\n")
          vim.notify("Failed to install ipykernel:\n" .. msg, vim.log.levels.ERROR)
        end
      end)
    end,
  })
end

local function install_molten_project_dependencies(venv_path, ask)
  if has_ipykernel(venv_path) then
    ensure_kernel_registered(venv_path)
    return
  end

  if ask then
    if vim.fn.confirm("Install ipykernel in " .. venv_path .. "?", "&Yes\n&No") == 1 then
      do_install_ipykernel(venv_path)
    end
  else
    do_install_ipykernel(venv_path)
  end
end

local function create_venv(path)
  vim.notify("Creating venv at " .. path .. "/.venv...")
  vim.fn.system("python3 -m venv " .. path .. "/.venv")
  vim.notify("Venv created")
end

local function setup_notebook_environment()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "quarto", "ipynb", "json" },
    callback = function(args)
      if args.match == "json" and not args.file:match("%.ipynb$") then
        return
      end
      local venv_path = find_nearest_venv()
      if venv_path then
        install_molten_project_dependencies(venv_path, true)
        return
      end

      if vim.fn.confirm("No venv found. Create one to run notebooks?", "&Yes\n&No") == 1 then
        local new_venv = find_best_venv_location_candidate()
        create_venv(new_venv)
        install_molten_project_dependencies(new_venv, false)
      end
    end,
  })
end

return {
  "benlubas/molten-nvim",
  version = "^1.0.0",
  dependencies = { "3rd/image.nvim" },
  build = ":UpdateRemotePlugins",
  init = function()
    vim.g.molten_image_provider = "snacks.nvim"
    vim.g.molten_output_win_max_height = 20
    vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
  end,
  config = function()
    setup_notebook_environment()
  end,
}
