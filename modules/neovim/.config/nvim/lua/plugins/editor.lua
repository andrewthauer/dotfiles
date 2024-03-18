return {
  -- file explorer
  -- https://github.com/nvim-neo-tree/neo-tree.nvim
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "Git explorer",
      },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Buffer explorer",
      },
    },
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    },
  },

  -- search/replace in multiple files
  -- https://github.com/nvim-pack/nvim-spectre
  {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },

  -- A Neovim plugin to easily create and manage predefined window layouts,
  -- bringing a new edge to your workflow.
  -- https://github.com/folke/edgy.nvim
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {}
  },

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

  -- which-key helps you remember key bindings by showing a popup
  -- with the active keybindings of the command you started typing.
  -- https://github.com/folke/which-key.nvim
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    -- init = function()
    --   vim.o.timeout = true
    --   vim.o.timeoutlen = 500
    -- end,
    opts = {},
  },

  -- git signs highlights text that has changed since the list
  -- git commit, and also lets you interactively stage & unstage
  -- hunks in a commit.
  -- https://github.com/lewis6991/gitsigns.nvim
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        -- map("n", "]h", gs.next_hunk, "Next Hunk")
        -- map("n", "[h", gs.prev_hunk, "Prev Hunk")
        -- map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        -- map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        -- map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        -- map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        -- map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        -- map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        -- map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        -- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },

  -- Automatically highlights other instances of the word under your cursor.
  -- This works with LSP, Treesitter, and regexp matching to find the other
  -- instances.
  -- https://github.com/RRethy/vim-illuminate
  -- {
  --   "RRethy/vim-illuminate",
  --   event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  --   keys = {
  --     { "]]", desc = "Next Reference" },
  --     { "[[", desc = "Prev Reference" },
  --   },
  -- },

  -- better diagnostics list and others
  -- https://github.com/folke/trouble.nvim
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      use_diagnostic_signs = true
    },
    -- keys = {
    --   { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics (Trouble)" },
    --   { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    --   { "<leader>xL", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List (Trouble)" },
    --   { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix List (Trouble)" },
    --   {
    --     "[q",
    --     function()
    --       if require("trouble").is_open() then
    --         require("trouble").previous({ skip_groups = true, jump = true })
    --       else
    --         local ok, err = pcall(vim.cmd.cprev)
    --         if not ok then
    --           vim.notify(err, vim.log.levels.ERROR)
    --         end
    --       end
    --     end,
    --     desc = "Previous trouble/quickfix item",
    --   },
    --   {
    --     "]q",
    --     function()
    --       if require("trouble").is_open() then
    --         require("trouble").next({ skip_groups = true, jump = true })
    --       else
    --         local ok, err = pcall(vim.cmd.cnext)
    --         if not ok then
    --           vim.notify(err, vim.log.levels.ERROR)
    --         end
    --       end
    --     end,
    --     desc = "Next trouble/quickfix item",
    --   },
    -- },
  },
}
