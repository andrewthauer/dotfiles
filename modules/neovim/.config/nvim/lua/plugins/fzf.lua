return {
  -- fzf-lua
  -- https://github.com/ibhagwan/fzf-lua
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    ---@diagnostic disable-next-line: unused-local
    opts = function(_, opts)
      local actions = require("fzf-lua.actions")

      return {
        "default-title",
        files = {
          cwd_prompt = false,
          -- rg_opts = [[--color=never --files --hidden --follow -g "!.git"]],
          rg_opts = [[--color=never --files --no-hidden --follow -g "!.git"]],
          actions = {
            ["alt-i"] = { actions.toggle_ignore },
            ["alt-h"] = { actions.toggle_hidden },
          },
        },
        grep = {
          rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
          actions = {
            ["alt-i"] = { actions.toggle_ignore },
            ["alt-h"] = { actions.toggle_hidden },
          },
        },
      }
    end,
    keys = {
      -- style: ignore start
      -- fast keys
      { "<leader>,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
      { "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
      { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader><cr>", "<cmd>FzfLua resume<cr>", desc = "Resume FzfLua" },
      -- { "<leader><space>", "<cmd>FzfLua files<cr>", desc = "Find Files" },
      -- document
      { "<leader>ds", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document Symbols (FzfLua)" },
      -- code
      { "<leader>cd", "<cmd>FzfLua lsp_definitions<cr>", desc = "Definitions (FzfLua)" },
      { "<leader>cD", "<cmd>FzfLua lsp_type_definitions<cr>", desc = "Type Definitions (FzfLua)" },
      { "<leader>ci", "<cmd>FzfLua lsp_implementations<cr>", desc = "Implementations (FzfLua)" },
      { "<leader>cci", "<cmd>FzfLua lsp_incoming_calls<cr>", desc = "Incoming Calls (FzfLua)" },
      { "<leader>cco", "<cmd>FzfLua lsp_outgoing_calls<cr>", desc = "Outgoing Calls (FzfLua)" },
      { "<leader>cR", "<cmd>FzfLua lsp_references<cr>", desc = "References (FzfLua)" },
      { "<leader>cs", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document Symbols (FzfLua)" },
      -- general
      -- find
      { "<leader>f.", "<cmd>FzfLua files cwd=~/.dotfiles<cr>", desc = "Find Dotfile" },
      { "<leader>fc", "<cmd>FzfLua files cwd=~/.config/nvim<cr>", desc = "Find Nvim Config File" },
      { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files" },
      -- { "<leader>fF", "<cmd>FzfLua files [TODO]<cr>", desc = "Find Files (Hidden)" },
      { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git)" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent Files" },
      -- git
      { "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Commits" },
      { "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Status" },
      -- goto
      { "<leader>gr", "<cmd>FzfLua lsp_references<cr>", desc = "References (FzfLua)" },
      -- search
      { "<leader>s^", "<cmd>FzfLua<cr>", desc = "FzfLua Pickers" },
      { '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
      { "<leader>gb", "<cmd>FzfLua current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document diagnostics" },
      { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace diagnostics" },
      { "<leader>sf", "<cmd>FzfLua filetypes<cr>", desc = "File Types" },
      { "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
      { "<leader>sG", "<cmd>FzfLua live_greg_glob<cr>", desc = "Grep Glob" },
      { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jump List" },
      { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
      { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List (Window)" },
      { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
      { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
      { "<leader>sp", "<cmd>FzfLua spell_suggest<cr>", desc = "Spell Suggest" },
      { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
      { "<leader>sQ", "<cmd>FzfLua quickfix_stack<r>", desc = "Quickfix History" },
      { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume FzfLua" },
      { "<leader>st", "<cmd>FzfLua tags<cr>", desc = "Tags" },
      { "<leader>sT", "<cmd>FzfLua current_buffer_tags<cr>", desc = "Tags (Current Buffer)" },
      { "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "Word" },
      { "<leader>sw", "<cmd>FzfLua grep_visual<cr>", desc = "Selection", mode = { "v" } },
      -- user setting
      { "<leader>uC", "<cmd>FzfLua colorschemes<cr>", desc = "Colorscheme with Preview" },
      -- workspace
      { "<leader>ws", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Workspace Symbols (FzfLua)" },
      { "<leader>wS", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", desc = "Workspace Symbols, Dynamic (FzfLua)" },
      -- style: ignore end
    },
    config = function(_, opts)
      require("fzf-lua").setup(opts)
    end,
  },
}
