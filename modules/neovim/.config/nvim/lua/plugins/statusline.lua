return {
  -- statusline
  -- https://github.com/nvim-lualine/lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    ---@diagnostic disable-next-line: unused-local
    opts = function(_, opts)
      return {
        theme = vim.g.colorscheme,
        -- sections = {
        --   lualine_a = { "mode" },
        -- },
      }
    end,
  },
}
