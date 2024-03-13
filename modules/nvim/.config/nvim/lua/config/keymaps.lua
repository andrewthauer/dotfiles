---- Global keymaps (not plugin specific)

local function map(kind, lhs, rhs, opts)
  vim.api.nvim_set_keymap(kind, lhs, rhs, opts)
end
-- local silentnoremap = { noremap = true, silent = true }

-- Conveniently enter command mode
-- Don't use silent=true as this removes the command line
-- map("n", ";", ":", { noremap = true })

-- Remap ESC key for insert mode
map("i", "kj", "<esc>", { noremap = true })

-- Allow repeating commands in visual mode
-- map("v", ".", ":norm", { noremap = true })

-- Intuitive increment and decrement
-- map('n', '+', '<c-a>', silentnoremap)
-- map('n', '-', '<c-x>', silentnoremap)

-- Navigate vim panes better
-- vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
-- vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
-- vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
-- vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- " So instead of ctrl-w then j, it’s just ctrl-j:
-- nnoremap <c-h> <c-w><c-h>       " Navigate pane left
-- nnoremap <c-j> <c-w><c-j>       " Navigate pane down
-- nnoremap <c-k> <c-w><c-k>       " Navigate pane up
-- nnoremap <c-l> <c-w><c-l>       " Navigate pane right
