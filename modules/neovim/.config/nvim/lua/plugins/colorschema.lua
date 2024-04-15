Util = require("util")

return {
  -- zenburn theme for nvim
  -- https://github.com/phha/zenburn.nvim
  {
    "phha/zenburn.nvim",
    lazy = false,
    priority = 1000, -- make sure to load this before other plugins start
    cond = vim.g.colorscheme == "zenburn",
    config = function()
      vim.cmd("colorscheme " .. vim.g.colorscheme)
    end,
  },

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

  -- https://github.com/EdenEast/nightfox.nvim
  -- variants:
  --   nightfox dayfox dawnfox duskfox nordfox terafox carbonfox
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000, -- make sure to load this before other plugins start
    cond = string.find(vim.g.colorscheme, "fox"),
    opts = {},
    config = function()
      vim.cmd("colorscheme " .. vim.g.colorscheme)
    end,
  },

  -- zenbones theme
  -- https://github.com/mcchrish/zenbones.nvim
  -- variants:
  --   zenwritten neobones vimbones rosebones forestbone nordbones
  --   tokyobones seoulbones duckbones zenburned kanagawabones
  {
    "mcchrish/zenbones.nvim",
    dependencies = {
      "rktjmp/lush.nvim",
    },
    lazy = false,
    priority = 1000, -- make sure to load this before other plugins start
    cond = string.find(vim.g.colorscheme, "bones") or vim.g.colorscheme == "zenburned",
    config = function()
      vim.cmd("colorscheme " .. vim.g.colorscheme)
    end,
  },
}
