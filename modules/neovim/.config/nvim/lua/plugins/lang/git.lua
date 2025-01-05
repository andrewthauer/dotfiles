return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "git_config", "gitcommit", "git_rebase", "gitattributes", "gitignore" },
    },
  },
}
