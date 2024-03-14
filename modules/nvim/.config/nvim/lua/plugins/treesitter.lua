return {
  -- synatx highlighting, etc.
  -- https://github.com/tree-sitter/tree-sitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      sync_install = true,
      auto_install = true,
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
        "graphql",
        "hcl",
        "helm",
        "html",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        -- "just",  -- see below
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
    -- -- @param opts TSConfig
    -- config = function(_, opts)
    --   if type(opts.ensure_installed) == "table" then
    --     -- @type table<string, boolean>
    --     local added = {}
    --     opts.ensure_installed = vim.tbl_filter(function(lang)
    --       if added[lang] then
    --         return false
    --       end
    --       added[lang] = true
    --       return true
    --     end, opts.ensure_installed)
    --   end
    --   require("nvim-treesitter.configs").setup(opts)
    -- end,
  },

  -- treesitter justfile support
  -- https://github.com/IndianBoy42/tree-sitter-just
  "IndianBoy42/tree-sitter-just",
}
