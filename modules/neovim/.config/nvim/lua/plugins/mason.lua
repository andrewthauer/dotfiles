return {
  {
    -- Portable package manager for Neovim
    -- https://github.com/williamboman/mason.nvim
    "williamboman/mason.nvim",
    cmd = "Mason",
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
      ---@diagnostic disable-next-line: different-requires
      require("util.mason").ensure_installed(opts)
    end,
  },
}
