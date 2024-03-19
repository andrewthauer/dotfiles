return {
  -- telescope fuzzy finder
  -- https://github.com/nvim-telescope/telescope.nvim
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
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    keys = function(_, keys)
      local builtin = require("telescope.builtin")
      local mappings = {
        { "<leader>t", "<cmd>Telescope<cr>", desc = "Telescope" },
        {
          "<leader>,",
          "<cmd>Telescope buffers sort_mru=true sort_lastused=true<CR>",
          desc = "Switch Buffer",
        },
        { "<leader>/", "<cmd>Telescope live_grep<CR>", desc = "Grep (root dir)" },
        { "<leader>:", "<cmd>Telescope command_history<CR>", desc = "Command History" },
        -- find
        { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<CR>", desc = "Buffers" },
        -- TODO: Add this back in without needing lazyvim utils
        -- { "<leader>fc", Util.telescope.config_files(), desc = "Find Config File" },
        {
          "<leader>ff",
          function()
            builtin.find_files({ hidden = true })
          end,
          desc = "Find Files (root dir)",
        },
        {
          "<leader>fg",
          "<cmd>Telescope git_files<cr>",
          desc = "Find Files (git-files)",
        },
        { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent" },
        -- { "<leader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
        -- -- git
        { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
        { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
        -- -- search
        { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
        -- { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
        -- { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
        { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
        -- { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
        -- { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
        -- { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
        -- { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
        { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
        -- { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
        -- { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
        -- { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
        -- { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
        -- { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
        -- { "<leader>sw", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
        -- { "<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
        -- { "<leader>sw", Util.telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
        -- { "<leader>sW", Util.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
        -- { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
        -- {
        --   "<leader>ss",
        --   function()
        --     require("telescope.builtin").lsp_document_symbols({
        --       symbols = require("lazyvim.config").get_kind_filter(),
        --     })
        --   end,
        --   desc = "Goto Symbol",
        -- },
        -- {
        --   "<leader>sS",
        --   function()
        --     require("telescope.builtin").lsp_dynamic_workspace_symbols({
        --       symbols = require("lazyvim.config").get_kind_filter(),
        --     })
        --   end,
        --   desc = "Goto Symbol (Workspace)",
        -- },
      }
      -- vim.list_extend(keys, my_keys)
      keys = mappings
      return keys
    end,
    ---@diagnostic disable-next-line: unused-local
    opts = function(_, _opts)
      local actions = require("telescope.actions")
      return {
        defaults = {
          layout_config = {
            horizontal = {
              height = 0.9,
              preview_cutoff = 120,
              prompt_position = "bottom",
              width = 0.8,
            },
            vertical = {
              height = 0.9,
              preview_cutoff = 40,
              prompt_position = "bottom",
              width = 0.8,
            },
          },
          -- your custom insert mode mappings
          mappings = {
            -- your custom normal mode mappings
            i = {
              ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              ["<C-j>"] = actions.move_selection_next, -- move to next result
              -- ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              -- map actions.which_key to <C-h> (default: <C-/>)
              -- ["<C-h>"] = "which_key"
              --
              -- from LazyVim
              --
              -- ["<c-t>"] = open_with_trouble,
              -- ["<a-t>"] = open_selected_with_trouble,
              -- ["<a-i>"] = find_files_no_ignore,
              -- ["<a-h>"] = find_files_with_hidden,
              -- ["<C-Down>"] = actions.cycle_history_next,
              -- ["<C-Up>"] = actions.cycle_history_prev,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
            },
            n = {
              ["q"] = actions.close,
            },
          },
        },
      }
    end,
  },
}
