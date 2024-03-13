-- Vim configuration in lua
-- https://neovim.io/doc/user/lua.html

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- use lazyvim
-- vim.g.lazyvim = true
vim.g.colorscheme = "zenburn"

-- bootstrap config & plugins
require("config.lazy")
