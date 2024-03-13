return {
  -- measure startuptime
  -- https://github.com/dstein64/vim-startuptime
  {
    "dstein64/vim-startuptime",
    enabled = false,
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
}
