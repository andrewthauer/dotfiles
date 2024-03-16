return {
  -- utils used by other libraries
  -- https://github.com/nvim-lua/plenary.nvim
  { "nvim-lua/plenary.nvim" },

  -- measure startuptime
  -- https://github.com/dstein64/vim-startuptime
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
}
