-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(kind, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.api.nvim_set_keymap(kind, lhs, rhs, opts)
end

-- Conveniently enter command mode
-- Don't use silent=true as this removes the command line
-- map("n", ";", ":", { noremap = true })

-- Remap ESC key for insert mode
map("i", "kj", "<Esc>", { noremap = true })

-- better up/down
-- map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", noremap = false })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", noremap = false })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", noremap = false })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", noremap = false })

-- Resize window using <ctrl> arrow keys
-- map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
-- map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
-- map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
-- map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down", noremap = true })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up", noremap = true })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down", noremap = true })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up", noremap = true })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down", noremap = true })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up", noremap = true })

-- buffers
-- map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
-- map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
-- map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Undo
map("n", "<D-z>", "<cmd>undo<cr>", { noremap = true })
map("i", "<D-z>", "<cmd>undo<cr>", { noremap = true })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
