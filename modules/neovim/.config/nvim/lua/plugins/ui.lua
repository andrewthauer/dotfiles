return {
  -- ui components
  -- https://github.com/MunifTanjim/nui.nvim
  { "MunifTanjim/nui.nvim", lazy = true },

  -- icons
  -- https://github.com/nvim-tree/nvim-web-devicons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- better vim.
  -- https://github.com/stevearc/dressing.nvim
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },

  -- indent guides for Neovim
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
    },
  },

  -- mini.bufremove [smart bufdelete]
  -- https://github.com/echasnovski/mini.bufremove
  -- Defines what tab to go on :bufdelete
  {
    "echasnovski/mini.bufremove",
    event = "User BaseFile",
  },

  -- open files & commands from term in current nvim instance
  -- https://github.com/willothy/flatten.nvim
  {
    "willothy/flatten.nvim",
    lazy = false,
    -- Ensure that it runs first to minimize delay when opening file from terminal
    priority = 1001,
    opts = {
      block_for = {
        gitcommit = true,
        gitrebase = true,
      },
    },
    config = true,
  },
}
