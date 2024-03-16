return {
  -- disable neo-tree
  -- https://github.com/nvim-neo-tree/neo-tree.nvim
  { "nvim-neo-tree/neo-tree.nvim", enabled = true },

  -- file explorer
  -- https://github.com/nvim-tree/nvim-tree.lua
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
    lazy = false,
    dependencies = { "nvim-web-devicons" },
    keys = {
      { "<leader>fe", "<cmd>NvimTreeToggle<cr>" },
    },
    opts = {
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
      },
    },
  },

  -- command palette / fuzzy finder
  -- https://github.com/ibhagwan/fzf-lua
  "junegunn/fzf",
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-web-devicons" },
    keys = {
      { "<C-p>", "<cmd>FzfLua files<cr>" },
      -- { "<C-o>", "<cmd>FzfLua commands<cr>" },
      -- { "<C-r>", "<cmd>FzfLua oldfiles<cr>" },
      -- { "<C-f>", "<cmd>FzfLua live_grep<cr>" },
      -- { "<C-g>", "<cmd>FzfLua git_files<cr>" },
      -- { "<C-b>", "<cmd>FzfLua buffers<cr>" },
      -- { "<C-h>", "<cmd>FzfLua help_tags<cr>" },
      -- { "<C-m>", "<cmd>FzfLua marks<cr>" },
      -- { "<C-s>", "<cmd>FzfLua lsp_document_symbols<cr>" },
      -- { "<C-t>", "<cmd>FzfLua lsp_workspace_symbols<cr>" },
      -- { "<C-w>", "<cmd>FzfLua lsp_workspace_diagnostics<cr>" },
      -- { "<C-y>", "<cmd>FzfLua yank_history<cr>" },
    },
  },

  -- which-key helps you remember key bindings by showing a popup
  -- with the active keybindings of the command you started typing.
  -- https://github.com/folke/which-key.nvim
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {},
    -- config = function(_, opts)
    --   local wk = require("which-key")
    --   wk.setup(opts)
    --   wk.register(opts.defaults)
    -- end,
  },
}
