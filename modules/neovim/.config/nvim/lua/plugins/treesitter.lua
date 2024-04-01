return {
  -- synatx highlighting, etc.
  -- https://github.com/nvim-treesitter/nvim-treesitter
  -- https://github.com/tree-sitter/tree-sitter
  --
  -- There are additional nvim-treesitter modules that you can use to interact with nvim-treesitter.
  --
  --   - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --   - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --   - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
      sync_install = true,
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "cue",
        "diff",
        "dockerfile",
        "git_config",
        "go",
        "gotmpl",
        "graphql",
        "hcl",
        "helm",
        "html",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "just",
        "jq",
        "kotlin",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "mermaid",
        "nix",
        "python",
        "query",
        "regex",
        "ruby",
        "rust",
        "sql",
        "ssh_config",
        "terraform",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- treesitter justfile support
  -- https://github.com/IndianBoy42/tree-sitter-just
  "IndianBoy42/tree-sitter-just",
}
