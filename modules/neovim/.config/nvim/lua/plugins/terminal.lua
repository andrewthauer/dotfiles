return {
  -- manage multiple terminal windows
  -- https://github.com/akinsho/toggleterm.nvim
  {
    "akinsho/toggleterm.nvim",
    opts = {
      open_mapping = [[<c-/>]],
      size = function(term)
        if term.direction == "horizontal" then
          return 20
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
    },
  },

  -- open files & commands from term in current nvim instance
  -- https://github.com/willothy/flatten.nvim
  {
    "willothy/flatten.nvim",
    -- cond = false,
    lazy = false,
    -- Ensure that it runs first to minimize delay when opening file from terminal
    priority = 1001,
    opts = function(_, opts)
      local saved_terminal

      opts = {
        window = {
          open = "smart",
        },
        callbacks = {
          should_block = function(argv)
            -- In this case, we would block if we find the `-b` flag
            -- This allows you to use `nvim -b file1` instead of
            -- `nvim --cmd 'let g:flatten_wait=1' file1`
            return vim.tbl_contains(argv, "-b")
          end,
          pre_open = function()
            local term = require("toggleterm.terminal")
            local termid = term.get_focused_id()
            saved_terminal = term.get(termid)
          end,
          post_open = function(bufnr, winnr, ft, is_blocking)
            if is_blocking and saved_terminal then
              -- Hide the terminal while it's blocking
              saved_terminal:toggle()
            else
              -- If it's a normal file, just switch to its window
              vim.api.nvim_set_current_win(winnr)
            end

            -- If the file is a git commit, create one-shot autocmd to delete its buffer on write
            -- If you just want the toggleable terminal integration, ignore this bit
            if ft == "gitcommit" or ft == "gitrebase" then
              vim.api.nvim_create_autocmd("BufWritePost", {
                buffer = bufnr,
                once = true,
                callback = vim.schedule_wrap(function()
                  -- delete the buffer (so blocking ends)
                  vim.api.nvim_buf_delete(bufnr, {})
                end),
              })
            end
          end,
          block_end = function()
            -- After blocking ends (for a git commit, etc), reopen the terminal
            vim.schedule(function()
              if saved_terminal then
                saved_terminal:open()
                saved_terminal = nil
              end
            end)
          end,
        },
      }

      return opts
    end,
    config = function(_, opts) ---@diagnostic disable-line: unused-local
      -- Set up flatten
      require("flatten").setup(opts)

      -- Override gf to use flatten when in a terminal
      -- see https://github.com/willothy/flatten.nvim/issues/85
      vim.keymap.set("n", "gf", function()
        -- if in a terminal, use flatten to open the file
        if vim.bo.buftype == "terminal" then
          require("flatten.core").edit_files({
            files = { vim.fn.expand("<cfile>") },
            stdin = {},
            argv = {},
            guest_cwd = vim.fn.getcwd(),
            force_block = false,
            response_pipe = "",
          })
        else
          -- otherwise use original gf
          vim.cmd("normal! gf")
        end
      end, { desc = "Open file under cursor" })
    end,
  },
}
