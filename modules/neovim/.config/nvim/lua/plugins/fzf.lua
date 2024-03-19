return {
  -- command palette / fuzzy finder
  -- https://github.com/ibhagwan/fzf-lua
  "junegunn/fzf",
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
}
