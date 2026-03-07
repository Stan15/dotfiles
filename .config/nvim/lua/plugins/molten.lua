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

local function has_ipykernel(venv_path)
  vim.fn.system(venv_path .. "/bin/pip show ipykernel 2>/dev/null")
  return vim.v.shell_error == 0
end

local function do_install_ipykernel(venv_path)
  vim.notify("Installing ipykernel in " .. venv_path .. "...")
  vim.fn.jobstart(venv_path .. "/bin/pip install ipykernel", {
    on_exit = function(_, code)
      vim.schedule(function()
        if code == 0 then
          vim.notify("ipykernel installed successfully")
        else
          vim.notify("Failed to install ipykernel", vim.log.levels.ERROR)
        end
      end)
    end,
  })
end

local function install_molten_project_dependencies(venv_path, ask)
  if has_ipykernel(venv_path) then
    return
  end

  if ask then
    vim.ui.select({ "Yes", "No" }, {
      prompt = "Install ipykernel in " .. venv_path .. "?",
    }, function(choice)
      if choice == "Yes" then
        do_install_ipykernel(venv_path)
      end
    end)
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

      vim.ui.select({ "Yes", "No" }, { prompt = "No venv found. Create one to run notebooks?" }, function(choice)
        if choice == "Yes" then
          local new_venv = find_best_venv_location_candidate()
          create_venv(new_venv)
          install_molten_project_dependencies(new_venv, false)
        end
      end)
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
