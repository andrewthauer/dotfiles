return {
  -- zenburn for nvim
  -- https://github.com/phha/zenburn.nvim
  {
    "phha/zenburn.nvim",
    lazy = false,
    priority = 1000, -- make sure to load this before other plugins start
    cond = vim.g.colorscheme == "zenburn",
    config = function()
      -- load the colorscheme here
      vim.cmd[[colorscheme zenburn]]
    end,
  },
}
