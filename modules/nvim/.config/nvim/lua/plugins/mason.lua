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
        -- "rubocop",
        -- "stylua",
        -- "shellcheck",
        "shfmt",
        -- "yamllint",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      -- require("util.mason").ensure_installed(opts)
    end,
  },
}
