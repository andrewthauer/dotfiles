return {
  -- zenburn for nvim
  -- https://github.com/phha/zenburn.nvim
  {
    "phha/zenburn.nvim",
    lazy = false,
    priority = 1000, -- make sure to load this before other plugins start
    cond = vim.g.colorscheme == "zenburn",
    config = function()
      vim.cmd("colorscheme zenburn")
    end,
  },

  -- zenbones
  {
    "mcchrish/zenbones.nvim",
    dependencies = {
      "rktjmp/lush.nvim",
    },
    lazy = false,
    priority = 1000, -- make sure to load this before other plugins start
    cond = vim.g.colorscheme == "zenburned",
    config = function()
      vim.cmd("colorscheme zenburned")
    end,
  },

  -- https://github.com/catppuccin/nvim
  {
    "catppuccin/nvim",
    priority = 1000,
    cond = vim.g.colorscheme == "catppuccin",
    config = function()
      vim.cmd("colorscheme catppuccin")
    end,
  },
}
