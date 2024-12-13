return {
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
