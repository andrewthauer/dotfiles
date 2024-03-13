return {
  -- LazyVim base
  -- http://www.lazyvim.org
  {
    "LazyVim/LazyVim",
    -- main = false,
    import = "lazyvim.plugins",
    enabled = true,
    opts = {
      colorscheme = vim.g.colorscheme,
    },
  },

  -- colorscheme
  {
    "phha/zenburn.nvim",
    lazy = false,
    priority = 1000,
    cond = vim.g.colorscheme == "zenburn",
    config = function()
      vim.cmd[[colorscheme zenburn]]
    end,
  },

  -- coding
  { "hrsh7th/nvim-cmp", enabled = false },
  { "hrsh7th/cmp-nvim-lsp", enabled = false },
  { "hrsh7th/cmp-buffer", enabled = false },
  { "hrsh7th/cmp-path", enabled = false },
  { "L3MON4D3/LuaSnip", enabled = false },
  { "saadparwaiz1/cmp_luasnip", enabled = false },
  { "rafamadriz/friendly-snippets", enabled = false },
  { "echasnovski/mini.pairs", enabled = false },
  { "echasnovski/mini.surround", enabled = false },
  { "JoosepAlviste/nvim-ts-context-commentstring", enabled = false },
  { "echasnovski/mini.comment", enabled = false },
  { "echasnovski/mini.ai", enabled = false },

  -- colorscheme
  { "folke/tokyonight.nvim", enabled = false },
  { "catppuccin/nvim", enabled = false },

  -- editor
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "nvim-pack/nvim-spectre", enabled = false },
  { "nvim-telescope/telescope-fzf-native.nvim", enabled = false },
  { "folke/flash.nvim", enabled = false },
  { "folke/which-key.nvim", enabled = false },
  { "lewis6991/gitsigns.nvim", enabled = false },
  { "RRethy/vim-illuminate", enabled = false },
  { "echasnovski/mini.bufremove", enabled = false },
  { "folke/trouble.nvim", enabled = false },
  { "folke/todo-comments.nvim", enabled = false },
  { "nvim-telescope/telescope.nvim", enabled = false },

  -- formatting
  { "stevearc/conform.nvim", enabled = false },

  -- linting
  { "mfussenegger/nvim-lint", enabled = false },

  -- lsp
  { "neovim/nvim-lspconfig", enabled = false },
  { "folke/neoconf.nvim", enabled = false },
  { "nvim-lspconfig", enabled = false },
  { "folke/neodev.nvim", enabled = false },
  { "mason.nvim", enabled = false },
  { "williamboman/mason-lspconfig.nvim", enabled = false },

  -- treesitter
  { "nvim-treesitter/nvim-treesitter", enabled = false },
  { "nvim-treesitter/nvim-treesitter-textobjects", enabled = false },
  { "nvim-treesitter/nvim-treesitter-context", enabled = false },
  { "windwp/nvim-ts-autotag", enabled = false },

  -- ui
  { "rcarriga/nvim-notify", enabled = false },
  { "stevearc/dressing.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  { "nvim-lualine/lualine.nvim", enabled = false },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  { "echasnovski/mini.indentscope", enabled = false },
  { "folke/which-key.nvim", enabled = false },
  { "folke/noice.nvim", enabled = false },
  { "nvim-tree/nvim-web-devicons", enabled = false },
  { "MunifTanjim/nui.nvim", enabled = false },
  { "nvimdev/dashboard-nvim", enabled = false },
  { "goolord/alpha-nvim", enabled = false },

  -- util
  { "dstein64/vim-startuptime", enabled = false },
  { "folke/persistence.nvim", enabled = false },
  { "nvim-lua/plenary.nvim", enabled = false },
}
