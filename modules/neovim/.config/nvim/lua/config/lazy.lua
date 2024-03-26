-- Use lazy.nvim to boostrap plugins and such
--
--   Inspired by http://www.lazyvim.org
--   https://github.com/folke/lazy.nvim
--

-- Setup lazy package manager (https://github.com/folke/lazy.nvimx)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins and such with lazy.nvim
-- https://github.com/folke/lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
    -- { import = "plugins.extras.cmp-cmdline" },
  },
  defaults = {
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
  },
  install = {
    -- install missing plugins on startup
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { vim.g.colorscheme },
  },
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    notify = true,
    frequency = 86400 -- check for updates once a day
  },
  change_detection = {
    -- automatically reload changed files and reload ui
    enabled = true,
    notify = true,
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
