-- This module allows us to enable/disable plugins if we want
-- the full LazyVim setup or not. Some plugins are always enabled
-- and some are not. This is a way to control that.

-- TODO: Make enabling/disabling plugins more flexible
local lazyvim_enabled = vim.g.lazyvim == true or false

return {
  -- always enabled (manually configured)
  -- { "akinsho/bufferline.nvim",                     enabled = true },
  -- { "dstein64/vim-startuptime",                    enabled = true },
  -- { "folke/neoconf.nvim",                          enabled = true },
  -- { "folke/persistence.nvim",                      enabled = true },
  -- { "folke/which-key.nvim",                        enabled = true },
  -- { "echasnovski/mini.comment",                    enabled = true },
  -- { "echasnovski/mini.pairs",                      enabled = true },
  -- { "echasnovski/mini.surround",                   enabled = true },
  -- { "hrsh7th/cmp-buffer",                          enabled = true },
  -- { "hrsh7th/cmp-nvim-lsp",                        enabled = true },
  -- { "hrsh7th/cmp-path",                            enabled = true },
  -- { "hrsh7th/nvim-cmp",                            enabled = true },
  -- { "L3MON4D3/LuaSnip",                            enabled = true },
  -- { "lewis6991/gitsigns.nvim",                     enabled = true },
  -- { "lukas-reineke/indent-blankline.nvim",         enabled = true },
  -- { "mason.nvim",                                  enabled = true },
  -- { "MunifTanjim/nui.nvim",                        enabled = true },
  -- { "neovim/nvim-lspconfig",                       enabled = true },
  -- { "nvim-lspconfig",                              enabled = true },
  -- { "nvim-lua/plenary.nvim",                       enabled = true },
  -- { "nvim-lualine/lualine.nvim",                   enabled = true },
  -- { "nvim-pack/nvim-spectre",                      enabled = true },
  -- { "nvim-neo-tree/neo-tree.nvim",                 enabled = true },
  -- { "nvim-telescope/telescope.nvim",               enabled = true },
  -- { "nvim-telescope/telescope-fzf-native.nvim",    enabled = true },
  -- { "nvim-tree/nvim-web-devicons",                 enabled = true },
  -- { "nvim-treesitter/nvim-treesitter",             enabled = true },
  -- { "nvimdev/dashboard-nvim",                      enabled = true },
  -- { "rafamadriz/friendly-snippets",                enabled = true },
  -- { "saadparwaiz1/cmp_luasnip",                    enabled = true },
  -- { "stevearc/conform.nvim",                       enabled = true },
  -- { "stevearc/dressing.nvim",                      enabled = true },
  -- { "williamboman/mason-lspconfig.nvim",           enabled = true },

  -- always but not customized
  { "folke/edgy.nvim",                             enabled = false },
  { "folke/trouble.nvim",                          enabled = lazyvim_enabled },
  { "JoosepAlviste/nvim-ts-context-commentstring", enabled = lazyvim_enabled },

  -- always disabled
  -- { "catppuccin/nvim",                             enabled = false },
  { "echasnovski/mini.ai",                         enabled = false },
  { "echasnovski/mini.bufremove",                  enabled = false },
  { "echasnovski/mini.indentscope",                enabled = false },
  { "folke/flash.nvim",                            enabled = false },
  { "folke/neodev.nvim",                           enabled = false },
  { "folke/noice.nvim",                            enabled = false },
  { "folke/todo-comments.nvim",                    enabled = false },
  { "folke/tokyonight.nvim",                       enabled = false },
  { "mfussenegger/nvim-lint",                      enabled = false },
  { "nvim-treesitter/nvim-treesitter-context",     enabled = false },
  { "nvim-treesitter/nvim-treesitter-textobjects", enabled = false },
  { "rcarriga/nvim-notify",                        enabled = false },
  { "RRethy/vim-illuminate",                       enabled = false },
  { "windwp/nvim-ts-autotag",                      enabled = false },
}
