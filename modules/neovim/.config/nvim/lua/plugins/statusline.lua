return {
  -- statusline
  -- https://github.com/nvim-lualine/lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    ---@diagnostic disable-next-line: unused-local
    opts = function(_, opts)
      return {
        options = {
          theme = vim.g.colorscheme,
          disabled_filetypes = {
            statusline = { "dashboard" },
          },
        },
        sections = {
          lualine_c = {
            { "filename", path = 1 },
          },
        },
        extensions = {
          "lazy",
          "man",
          "mason",
          "neo-tree",
          "quickfix",
          "trouble",
          "toggleterm",
        },
      }
    end,
  },
}
