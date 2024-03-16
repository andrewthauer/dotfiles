-- This module allows us to enable/disable plugins if we want
-- the full LazyVim setup or not. Some plugins are always enabled
-- and some are not. This is a way to control that.

-- TODO: Make enabling/disabling plugins more flexible
local lazyvim_enabled = vim.g.lazyvim == true or false

return {
  -- always enabled (manually configured)
  { "dstein64/vim-startuptime",                    enabled = true },
  { "folke/which-key.nvim",                        enabled = true },
  { "echasnovski/mini.comment",                    enabled = true },
  { "hrsh7th/cmp-buffer",                          enabled = true },
  { "hrsh7th/cmp-nvim-lsp",                        enabled = true },
  { "hrsh7th/cmp-path",                            enabled = true },
  { "hrsh7th/nvim-cmp",                            enabled = true },
  { "L3MON4D3/LuaSnip",                            enabled = true },
  { "mason.nvim",                                  enabled = true },
  { "neovim/nvim-lspconfig",                       enabled = true },
  { "nvim-lspconfig",                              enabled = true },
  { "nvim-lua/plenary.nvim",                       enabled = true },
  { "nvim-lualine/lualine.nvim",                   enabled = true },
  { "nvim-telescope/telescope-fzf-native.nvim",    enabled = true },
  { "nvim-telescope/telescope.nvim",               enabled = true },
  { "nvim-tree/nvim-web-devicons",                 enabled = true },
  { "nvim-treesitter/nvim-treesitter",             enabled = true },
  { "rafamadriz/friendly-snippets",                enabled = true },
  { "saadparwaiz1/cmp_luasnip",                    enabled = true },
  { "stevearc/conform.nvim",                       enabled = true },
  { "stevearc/dressing.nvim",                      enabled = true },
  { "williamboman/mason-lspconfig.nvim",           enabled = true },

  -- always but not customized
  { "echasnovski/mini.surround",                   enabled = true },
  { "echasnovski/mini.pairs",                      enabled = true },
  { "folke/persistence.nvim",                      enabled = true },
  { "folke/trouble.nvim",                          enabled = true },
  { "lukas-reineke/indent-blankline.nvim",         enabled = true },
  { "nvim-neo-tree/neo-tree.nvim",                 enabled = true },

  -- always disabled
  { "catppuccin/nvim",                             enabled = false },
  { "folke/flash.nvim",                            enabled = false },
  { "folke/neodev.nvim",                           enabled = false },
  { "folke/noice.nvim",                            enabled = false },
  { "folke/todo-comments.nvim",                    enabled = false },
  { "folke/tokyonight.nvim",                       enabled = false },
  { "rcarriga/nvim-notify",                        enabled = false },

  -- unsure
  { "akinsho/bufferline.nvim",                     enabled = lazyvim_enabled },
  { "folke/neoconf.nvim",                          enabled = lazyvim_enabled },
  { "MunifTanjim/nui.nvim",                        enabled = lazyvim_enabled },
  { "nvimdev/dashboard-nvim",                      enabled = lazyvim_enabled },

  -- when lazyvim is enabled
  { "echasnovski/mini.ai",                         enabled = lazyvim_enabled },
  { "echasnovski/mini.bufremove",                  enabled = lazyvim_enabled },
  { "echasnovski/mini.indentscope",                enabled = lazyvim_enabled },
  { "JoosepAlviste/nvim-ts-context-commentstring", enabled = lazyvim_enabled },
  { "lewis6991/gitsigns.nvim",                     enabled = lazyvim_enabled },
  { "mfussenegger/nvim-lint",                      enabled = lazyvim_enabled },
  { "nvim-pack/nvim-spectre",                      enabled = lazyvim_enabled },
  { "nvim-treesitter/nvim-treesitter-context",     enabled = lazyvim_enabled },
  { "nvim-treesitter/nvim-treesitter-textobjects", enabled = lazyvim_enabled },
  { "RRethy/vim-illuminate",                       enabled = lazyvim_enabled },
  { "windwp/nvim-ts-autotag",                      enabled = lazyvim_enabled },
}
