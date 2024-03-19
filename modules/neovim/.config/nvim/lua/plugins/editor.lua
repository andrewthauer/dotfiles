return {
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
    config = function()
      require("which-key").setup()

      -- Document existing key chains
      -- require("which-key").register({
      --   ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
      --   ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
      --   ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
      --   ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
      --   ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
      -- })
    end,
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
}
