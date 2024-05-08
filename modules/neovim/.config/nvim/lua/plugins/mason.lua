return {
  {
    -- Portable package manager for Neovim
    -- https://github.com/williamboman/mason.nvim
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
    },
    opts = {
      ensure_installed = {
        "rubocop",
        "shellcheck",
        "shfmt",
        "stylua",
        "yamllint",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      require("util").plugin.ensure_installed(opts)
    end,
  },
}
