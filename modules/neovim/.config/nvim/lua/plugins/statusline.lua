return {
  -- statusline
  -- https://github.com/nvim-lualine/lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function(_, opts)
      table.insert(opts.sources or {}, {
        theme = "zenburn",
      })
    end,
  },
}
