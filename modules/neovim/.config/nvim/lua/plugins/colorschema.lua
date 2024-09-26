return {
  -- catppuccin
  -- https://github.com/catppuccin/nvim
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000, -- make sure to load this before other plugins start
    cond = string.find(vim.g.colorscheme, "catppuccin"),
    opts = {},
    config = function()
      vim.cmd("colorscheme " .. vim.g.colorscheme)
    end,
  },
}
