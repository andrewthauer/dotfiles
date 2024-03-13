return {
  -- zenburn for nvim
  -- https://github.com/phha/zenburn.nvim
  {
    "phha/zenburn.nvim",
    lazy = false,
    priority = 1000,
    cond = vim.g.colorscheme == "zenburn",
    config = function()
      vim.cmd[[colorscheme zenburn]]
    end,
  },
}
