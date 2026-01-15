local zymewire_add_env_symlink_hook = function(op, metadata)
  local Worktree = require("git-worktree")
  if op == "create" then
    local worktree_path = Worktree.get_worktree_path(metadata.path)
    -- Use plain string matching (4th param = true) to avoid pattern interpretation
    if string.find(worktree_path, "zymewire-rails-app", 1, true) then
      local source = vim.fn.expand("~/projects/support_files/rails_env_variables.env")
      local target = worktree_path .. "/.env"
      local result = vim.fn.system({ "ln", "-s", source, target })
      if vim.v.shell_error ~= 0 then
        vim.notify("Zymewire .env symlink failed: " .. result, vim.log.levels.ERROR)
      else
        vim.notify("Zymewire .env symlink created at " .. target, vim.log.levels.INFO)
      end
    end
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
    Worktree.on_tree_change(zymewire_add_env_symlink_hook)
    vim.notify("git-worktree: callback registered", vim.log.levels.INFO)
  end,
}
