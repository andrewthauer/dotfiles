return {
  -- which-key helps you remember key bindings by showing a popup
  -- with the active keybindings of the command you started typing.
  -- https://github.com/folke/which-key.nvim
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    ---@diagnostic disable-next-line: unused-local
    config = function(_, _opts)
      local wk = require("which-key")
      wk.add({
        { "g", desc = "+Goto" },
        { "gr", desc = "+Code Actions" },
        { "gs", desc = "+Surround" },
        { "z", desc = "+Fold" },
        { "]", desc = "+Next" },
        { "[", desc = "+Prev" },
        { "<leader><tab>", desc = "+Tabs" },
        { "<leader>b", desc = "+Buffers" },
        { "<leader>c", desc = "+Code" },
        { "<leader>d", desc = "+Document/Debug" },
        { "<leader>f", desc = "+File/find" },
        { "<leader>g", desc = "+Git/Goto" },
        { "<leader>m", desc = "+Multiple Cursors" },
        { "<leader>q", desc = "+Quit/Session" },
        { "<leader>s", desc = "+Search" },
        { "<leader>u", desc = "+UI Toggles" },
        { "<leader>w", desc = "+Windows/Workspace" },
        { "<leader>x", desc = "+Diagnostics/Quickfix" },
      })
    end,
  },

  -- search/replace in multiple files
  -- https://github.com/MagicDuck/grug-far.nvim
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
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
        -- stylua: ignore end
      end,
    },
  },

  -- git sharable links
  -- https://github.com/linrongbin16/gitlinker.nvim
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    opts = {},
    keys = {
      { "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
      { "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
    },
  },

  -- better diagnostics list and others
  -- https://github.com/folke/trouble.nvim
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      use_diagnostic_signs = true,
    },
    keys = {
      -- stylua: ignore start
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      -- stylua: ignore end
    },
  },

  -- multiple curors
  -- https://github.com/jake-stewart/multicursor.nvim
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    enabled = false,
    config = function()
      local mc = require("multicursor-nvim")

      mc.setup({
        -- set to true if you want multicursor undo history
        -- to clear when clearing cursors
        shallowUndo = false,

        -- set to empty table to disable signs
        signs = { " ┆", " │", " ┃" },
      })

      -- Add cursors above/below the main cursor.
      vim.keymap.set({ "n", "v" }, "<up>", function()
        mc.addCursor("k")
      end, { desc = "Add Cursor (above)" })
      vim.keymap.set({ "n", "v" }, "<down>", function()
        mc.addCursor("j")
      end, { desc = "Add Cursor (below)" })

      -- Add a cursor and jump to the next word under cursor.
      vim.keymap.set({ "n", "v" }, "<c-n>", function()
        mc.addCursor("*")
      end, { desc = "Add Cursor (next)" })

      -- Jump to the next word under cursor but do not add a cursor.
      vim.keymap.set({ "n", "v" }, "<c-s>", function()
        mc.skipCursor("*")
      end, { desc = "Skip Cursor" })

      -- Rotate the main cursor.
      vim.keymap.set({ "n", "v" }, "<left>", mc.nextCursor, { desc = "Next Cursor" })
      vim.keymap.set({ "n", "v" }, "<right>", mc.prevCursor, { desc = "Prev Cursor" })

      -- Delete the main cursor.
      vim.keymap.set({ "n", "v" }, "<leader>mx", mc.deleteCursor, { desc = "Delete Cursor" })

      -- Add and remove cursors with control + left click.
      vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse, { desc = "Add/Remove Cursor" })

      vim.keymap.set({ "n", "v" }, "<c-q>", function()
        if mc.cursorsEnabled() then
          -- Stop other cursors from moving.
          -- This allows you to reposition the main cursor.
          mc.disableCursors()
        else
          mc.addCursor()
        end
      end, { desc = "Toggle Cursor" })

      -- clone every cursor and disable the originals
      vim.keymap.set({ "n", "v" }, "<c-q>", function()
        mc.duplicateCursors()
      end, { desc = "Duplicate Cursors" })

      vim.keymap.set("n", "<c-esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        elseif mc.hasCursors() then
          mc.clearCursors()
        else
          -- Default <esc> handler.
        end
      end, { noremap = true, desc = "Clear Cursors" })

      -- Align cursor columns.
      vim.keymap.set("n", "<leader>ma", mc.alignCursors, { desc = "Align Cursors" })

      -- Split visual selections by regex.
      vim.keymap.set("v", "S", mc.splitCursors, { desc = "Split Cursors" })

      -- Append/insert for each line of visual selections.
      vim.keymap.set("v", "I", mc.insertVisual, { desc = "Insert Visual" })
      vim.keymap.set("v", "A", mc.appendVisual, { desc = "Append Visual" })

      -- match new cursors within visual selections by regex.
      vim.keymap.set("v", "M", mc.matchCursors, { desc = "Match Cursors" })

      -- Rotate visual selection contents.
      vim.keymap.set("v", "<leader>mt", function()
        mc.ransposeCursors(1)
      end, { desc = "Transpose Cursor (forward)" })
      vim.keymap.set("v", "<leader>mT", function()
        mc.transposeCursors(-1)
      end, { desc = "Transpose Cursor (back)" })

      -- Customize how cursors look.
      vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
      vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
      vim.api.nvim_set_hl(0, "MultiCursorSign", { link = "SignColumn" })
      vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
      vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      vim.api.nvim_set_hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
  },
}
