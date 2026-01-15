return {
  "ThePrimeagen/git-worktree.nvim",
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
    require("git-worktree").setup()
    require("lazyvim.util").on_load("telescope.nvim", function()
      require("telescope").load_extension("git_worktree")
    end)

    local Worktree = require("git-worktree")
    Worktree.on_tree_change(function(op, metadata)
      if op == Worktree.Operations.Create then
        if string.find(metadata.path, "zymewire-rails-app") then
          vim.notify("Yo! New worktree: " .. metadata.path)
          vim.fn.system("ln -s ~/projects/support_files/rails_env_variables.env " .. metadata.path .. "/.env")
        end
      end
    end)
  end,
}
