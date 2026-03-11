local link_zymewire_env_vars = function(worktree_path)
  vim.notify("git-worktree: sym-linking zymewire environment vars...", vim.log.levels.INFO)

  local source = vim.fn.expand("~/projects/support_files/rails_env_variables.env")
  local target = worktree_path .. "/.env"
  local result = vim.fn.system({ "ln", "-s", source, target })
  if vim.v.shell_error ~= 0 then
    vim.notify("git-worktree: zymewire .env symlink failed: " .. result, vim.log.levels.ERROR)
  else
    vim.notify("git-worktree: zymewire .env symlink created at " .. target, vim.log.levels.INFO)
  end
end

local create_log_directory = function(worktree_path)
  vim.notify("git-worktree: creating log directory...", vim.log.levels.INFO)

  local log_dir = worktree_path .. "/log"
  local result = vim.fn.mkdir(log_dir, "p")
  if result == 0 then
    vim.notify("git-worktree: log directory creation failed", vim.log.levels.ERROR)
  else
    vim.notify("git-worktree: log directory created at " .. log_dir, vim.log.levels.INFO)
  end
end

local init_submodules = function(worktree_path)
  vim.notify("git-worktree: initializing git submodules...", vim.log.levels.INFO)

  local result = vim.fn.system({ "git", "-C", worktree_path, "submodule", "update", "--init", "--recursive" })
  if vim.v.shell_error ~= 0 then
    vim.notify("git-worktree: could not initialize git submodules: " .. result, vim.log.levels.ERROR)
  else
    vim.notify("git-worktree: git submodules initialized.", vim.log.levels.INFO)
  end
end

local setup_zymewire_worktree = function(worktree_path)
  -- Use plain string matching (4th param = true) to avoid pattern interpretation
  if string.find(worktree_path, "zymewire-rails-app", 1, true) then
    link_zymewire_env_vars(worktree_path)
    create_log_directory(worktree_path)
    init_submodules(worktree_path)
  end
end

return {
  "ThePrimeagen/git-worktree.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  lazy = false,
  keys = {
    {
      "<leader>gwl",
      function()
        require("telescope").extensions.git_worktree.git_worktrees()
      end,
      desc = "Manage Git Worktrees",
    },
    {
      "<leader>gwa",
      function()
        require("telescope").extensions.git_worktree.create_git_worktree()
      end,
      desc = "Add Git Worktree",
    },
    {
      "<leader>gwp",
      function()
        vim.fn.system("git worktree prune")
        vim.notify("Git worktrees pruned", vim.log.levels.INFO)
      end,
      desc = "Prune Git Worktrees",
    },
  },

  config = function()
    local Worktree = require("git-worktree")
    Worktree.setup()
    require("telescope").load_extension("git_worktree")

    -- Register callback
    Worktree.on_tree_change(zymewire_setup_worktree_hook)
    Worktree.on_tree_change(function(op, metadata)
      local worktree_path = Worktree.get_worktree_path(metadata.path)
      if op == "create" then
        setup_zymewire_worktree(worktree_path)
      end
    end)
    vim.notify("git-worktree: callback registered", vim.log.levels.INFO)
  end,
}
