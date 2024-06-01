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
      local Util = require("util")
      local mappings = {
        -- style: ignore start
        -- fast keys
        { "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
        { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
        { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        -- telescope general
        { "<leader>tp", "<cmd>Telescope<cr>", desc = "Telescope Pickers" },
        { "<leader>tr", "<cmd>Telescope resume<cr>", desc = "Resume Telescope" },
        -- find
        { "<leader>f.", Util.telescope.dotfiles, desc = "Find Dotfile" },
        { "<leader>fc", Util.telescope.config_files, desc = "Find Config File" },
        { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
        { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
        { "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find Files" },
        { "<leader>fF", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", desc = "Find Files (Hidden)" },
        { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git)" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
        -- git
        { "leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
        { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Status" },
        -- search
        { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
        { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
        { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
        { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
        { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
        { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
        { "<leader>sf", "<cmd>Telescope filetypes<cr>", desc = "File Types" },
        { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
        { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
        { "<leader>sH", "<cmd>Telescope search_history<cr>", desc = "Search History" },
        { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jump List" },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
        { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Location List (Window)" },
        { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
        { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
        { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
        { "<leader>sp", "<cmd>Telescope spell_suggest<cr>", desc = "Spell Suggest" },
        { "<leader>ss", "<cmd>Telescope symbols<cr>", desc = "Symbols" },
        { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix" },
        { "<leader>sQ", "<cmd>Telescope quickfixhistory<cr>", desc = "Quickfix History" },
        { "<leader>st", "<cmd>Telescope tags<cr>", desc = "Tags" },
        { "<leader>sT", "<cmd>Telescope current_buffer_tags<cr>", desc = "Tags (Current Buffer)" },
        -- user settings
        { "<leader>uC", "<cmd>Telescope colorscheme enable_preview=true<cr>", desc = "Colorscheme with Preview" },
        -- style: ignore end
      }
      return vim.tbl_extend("force", keys, mappings)
    end,
    ---@diagnostic disable-next-line: unused-local
    opts = function(_, _opts)
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      local builtin = require("telescope.builtin")

      local find_files = function(opts)
        return function()
          opts = opts or {}
          opts.default_text = action_state.get_current_line()
          opts.hidden = opts.hidden or false
          opts.no_ignore = opts.no_ignore or false
          builtin.find_files(opts)
        end
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
            "%.git/",
            "!%.github/",
            "%.cache",
            "node_modules",
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
              ["<A-a>"] = find_files({ hidden = true, no_ignore = true }),
              ["<A-i>"] = find_files({ no_ignore = true }),
              ["<A-h>"] = find_files({ hidden = true }),
              ["<C-t>"] = open_with_trouble,
              ["<A-t>"] = open_selected_with_trouble,
              -- map actions.which_key to <C-h> (default: <C-/>)
              ["<C-h>"] = "which_key",
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
