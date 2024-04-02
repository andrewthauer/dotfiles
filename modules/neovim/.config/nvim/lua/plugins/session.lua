return {
  -- project & session manager
  -- https://github.com/coffebar/neovim-project
  {
    "coffebar/neovim-project",
    lazy = false,
    priority = 100,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
      -- https://github.com/Shatur/neovim-session-manager
      { "Shatur/neovim-session-manager" },
    },
    keys = {
      -- stylua: ignore start
      { "<leader>fp", "<cmd>Telescope neovim-project discover<cr>", desc = "Projects" },
      { "<leader>qr", "<cmd>NeovimProjectLoadRecent<cr>", desc = "Restore Last Session" },
      { "<leader>ql", function() require("session_manager").load_session(false) end, desc = "Load Session" },
      { "<leader>qL", function() require("session_manager").load_current_dir_session(false) end, desc = "Restore Dir Session" },
      { "<leader>qs", function() require("session_manager").save_current_session() end, desc = "Save Session" },
      { "<leader>qd", function() require("session_manager").delete_session() end, desc = "Delete Session" },
      { "<leader>qD", function() require("session_manager").delete_current_dir_session() end, desc = "Delete Current Dir Session" },
      -- stylua: ignore end
    },
    opts = {
      projects = vim.g.projects or {
        "~/.config/*",
      },
      dashboard_mode = true,
      last_session_on_startup = false,
      -- https://github.com/Shatur/neovim-session-manager
      session_manager_opts = {},
    },
    init = function()
      -- enable saving the state of plugins in the session
      -- save global variables that start with an uppercase letter and contain at least one lowercase letter
      vim.opt.sessionoptions:append("globals")
    end,
  },
}
