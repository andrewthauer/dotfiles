return {
  -- NOTE: Only require this when not using LazyVim
  {
    dir = ".",
    priority = 10001, -- load before everything
    lazy = false,
    cond = vim.g.lazyvim == false,
    init = function()
      require("config.keymaps")
      require("config.autocmds")
    end,
    dependencies = {
      {
        dir = ".",
        init = function()
          require("config.options")
        end
      },
    },
  },

  -- Require LazyVim for util functions only (no plugins)
  {
    "LazyVim/LazyVim",
    lazy = false,
    priority = 10000, -- load before everything
    cond = vim.g.lazyvim == false and vim.g.lazyvim_bare == true,
    init = function()
      print("Initialize LazyVim without plugins")
    end,
    config = function()
      print("Configure LazyVim without plugins")
    end,
  },

  -- otherwise, require LazyVim and import its plugins
  {
    "LazyVim/LazyVim",
    import = "lazyvim.plugins",
    cond = vim.g.lazyvim == true,
    opts = {
      colorscheme = vim.g.colorscheme,
    },
  },
}
