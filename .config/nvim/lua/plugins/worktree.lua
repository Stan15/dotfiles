local link_work_env_vars = function(worktree_path)
  vim.notify("worktree: sym-linking environment vars...", vim.log.levels.INFO)

  local source = vim.fn.expand(vim.env.WORK_ENVIRONMENT_VARS_PATH)
  local target = worktree_path .. "/.env"
  local result = vim.fn.system({ "ln", "-s", source, target })
  if vim.v.shell_error ~= 0 then
    vim.notify("worktree: work .env symlink failed: " .. result, vim.log.levels.ERROR)
  else
    vim.notify("worktree: work .env symlink created at " .. target, vim.log.levels.DEBUG)
  end
end

local create_log_directory = function(worktree_path)
  vim.notify("git-worktree: creating log directory...", vim.log.levels.INFO)

  local log_dir = worktree_path .. "/log"
  local result = vim.fn.mkdir(log_dir, "p")
  if result == 0 then
    vim.notify("worktree: log directory creation failed", vim.log.levels.ERROR)
  else
    vim.notify("worktree: log directory created at " .. log_dir, vim.log.levels.DEBUG)
  end
end

local init_submodules = function(worktree_path)
  vim.notify("worktree: initializing git submodules...", vim.log.levels.INFO)

  local result = vim.fn.system({ "git", "-C", worktree_path, "submodule", "update", "--init", "--recursive" })
  if vim.v.shell_error ~= 0 then
    vim.notify("worktree: could not initialize git submodules: " .. result, vim.log.levels.ERROR)
  else
    vim.notify("worktree: git submodules initialized.", vim.log.levels.DEBUG)
  end
end

local is_work_repo = function(worktree_path)
  local remote = vim.fn.system({ "git", "-C", worktree_path, "config", "--get", "remote.origin.url" })
  if vim.v.shell_error ~= 0 then
    return false
  end
  local expected_remote = vim.env.WORK_REPO_REMOTE
  if not expected_remote then
    return false
  end
  return vim.trim(remote) == expected_remote
end

local export_i18n_translations = function(worktree_path)
  vim.notify("worktree: exporting i18n translations...", vim.log.levels.INFO)

  local result = vim.fn.system({ "bash", "-c", "cd " .. vim.fn.shellescape(worktree_path) .. " && bundle exec rake i18n:js:export" })
  if vim.v.shell_error ~= 0 then
    vim.notify("worktree: i18n:js:export failed: " .. result, vim.log.levels.ERROR)
  else
    vim.notify("worktree: i18n translations exported.", vim.log.levels.DEBUG)
  end
end

local setup_work_worktree = function(worktree_path)
  if not is_work_repo(worktree_path) then return false end
  link_work_env_vars(worktree_path)
  create_log_directory(worktree_path)
  init_submodules(worktree_path)
  export_i18n_translations(worktree_path)
  return true
end

return {
  "Stan15/worktrees.nvim",
  event = "VeryLazy",
  config = function()
    require("worktrees").setup({
      path_template = function(branch)
        -- Handles 'username/team-123-description' or 'team-123-description'
        local slug = branch:match(".*/(.+)") or branch
        -- Captures everything after 'alphanumeric-digits-'
        return slug:match("^%w+%-%d+%-(.+)") or slug
      end,
      on_create = function(path)
        if setup_work_worktree(path) then
          vim.notify("worktree: work environment set up at " .. path, vim.log.levels.INFO)
        end
      end,
      on_switch = function(from_path, to_path)
        vim.notify(
          "worktree: switched from "
            .. vim.fn.fnamemodify(from_path, ":t")
            .. " to "
            .. vim.fn.fnamemodify(to_path, ":t"),
          vim.log.levels.INFO
        )
      end,
      mappings = {
        create = "<leader>wtc",
        switch = "<leader>wts",
        delete = "<leader>wtd",
      },
    })
  end,
}
