return {
  -- file explorer
  -- https://github.com/nvim-tree/nvim-tree.lua
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = { "nvim-web-devicons" },
    keys = {
      { "<c-b>", ":NvimTreeToggle<cr>" },
      { "<c-n>", ":NvimTreeFindFile<cr>" },
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
      { "<c-p>", "<cmd>FzfLua files<cr>" },
      -- { "<c-o>", "<cmd>FzfLua commands<cr>" },
      -- { "<c-r>", "<cmd>FzfLua oldfiles<cr>" },
      -- { "<c-f>", "<cmd>FzfLua live_grep<cr>" },
      -- { "<c-g>", "<cmd>FzfLua git_files<cr>" },
      -- { "<c-b>", "<cmd>FzfLua buffers<cr>" },
      -- { "<c-h>", "<cmd>FzfLua help_tags<cr>" },
      -- { "<c-m>", "<cmd>FzfLua marks<cr>" },
      -- { "<c-s>", "<cmd>FzfLua lsp_document_symbols<cr>" },
      -- { "<c-t>", "<cmd>FzfLua lsp_workspace_symbols<cr>" },
      -- { "<c-w>", "<cmd>FzfLua lsp_workspace_diagnostics<cr>" },
      -- { "<c-y>", "<cmd>FzfLua yank_history<cr>" },
    },
  },

  -- telescope fuzzy finder
  -- https://github.com/nvim-telescope/telescope.nvim
  "nvim-telescope/telescope-fzf-native.nvim",
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", {} },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", {} },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", {} },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", {} },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            -- map actions.which_key to <C-h> (default: <C-/>)
            -- actions.which_key shows the mappings for your picker,
            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            ["<C-h>"] = "which_key"
          }
        }
      },
    },
    -- config = function()
    --   local telescope = require("telescope")
    --   -- local actions = require("telescope.actions")
    --   telescope.load_extension("fzf")
    -- end,
  },

  -- which-key helps you remember key bindings by showing a popup
  -- with the active keybindings of the command you started typing.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
    -- config = function(_, opts)
    --   local wk = require("which-key")
    --   wk.setup(opts)
    --   wk.register(opts.defaults)
    -- end,
  },
}
