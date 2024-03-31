return {
  -- telescope fuzzy finder
  -- https://github.com/nvim-telescope/telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
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
      local Util = require("util")
      local mappings = {
        { "<leader>t", "<cmd>Telescope<cr>", desc = "Telescope" },
        {
          "<leader>,",
          "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
          desc = "Switch Buffer",
        },
        { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
        { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        -- find
        { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
        { "<leader>fc", Util.telescope.config_files, desc = "Find Config File" },
        {
          "<leader>ff",
          function()
            builtin.find_files({ hidden = true, no_ignore = true })
          end,
          desc = "Find Files (Hidden)",
        },
        { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
        -- git
        { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "commits" },
        { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "status" },
        -- search
        { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
        { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
        { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
        { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
        { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
        { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
        { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
        { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
        { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
        { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      }
      return vim.tbl_extend("force", keys, mappings)
    end,
    ---@diagnostic disable-next-line: unused-local
    opts = function(_, _opts)
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      local builtin = require("telescope.builtin")

      local find_files_no_ignore = function()
        local line = action_state.get_current_line()
        builtin.find_files({ hidden = true, no_ignore = true, default_text = line })
      end

      local find_files_with_hidden = function()
        local line = action_state.get_current_line()
        builtin.find_files({ hidden = true, default_text = line })
      end

      local open_with_trouble = function(...)
        return require("trouble.providers.telescope").open_with_trouble(...)
      end

      local open_selected_with_trouble = function(...)
        return require("trouble.providers.telescope").open_selected_with_trouble(...)
      end

      return {
        defaults = {
          file_ignore_patterns = {
            ".git/",
            ".cache",
          },
          mappings = {
            -- custom normal mode mappings
            n = {
              ["q"] = actions.close,
            },
            -- custom insert mode mappings
            i = {
              ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              ["<C-j>"] = actions.move_selection_next, -- move to next result
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<A-i>"] = find_files_no_ignore,
              ["<A-h>"] = find_files_with_hidden,
              ["<C-t>"] = open_with_trouble,
              ["<A-t>"] = open_selected_with_trouble,
              -- map actions.which_key to <C-h> (default: <C-/>)
              ["<C-h>"] = "which_key"
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
          grep_string = {
            additional_args = { "--hidden" },
          },
          live_grep = {
            additional_args = { "--hidden" },
          },
        },
      }
    end,
  },
}
