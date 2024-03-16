return {
  -- statusline
  -- https://github.com/nvim-lualine/lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function(_, opts)
      table.insert(opts.sources or {}, { theme = "zenburn" })
    end,
  },

  -- icons
  -- https://github.com/nvim-tree/nvim-web-devicons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- better vim.ui
  -- https://github.com/stevearc/dressing.nvim
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },
}
