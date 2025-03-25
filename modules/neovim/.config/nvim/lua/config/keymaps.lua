-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- stylua: ignore start

local Util = require("util")

local function map(kind, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(kind, lhs, rhs, opts)
end

-- Conveniently enter command mode
-- Don't use silent=true as this removes the command line
-- map("n", ";", ":", { noremap = true })

-- Remap ESC key for insert mode
map("i", "jk", "<esc>", { noremap = true, desc = "Alternative escape key" })
map("i", "kj", "<esc>", { noremap = true, desc = "Alternative escape key" })

-- Quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Buffers
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })

-- Buffer prev/next
-- map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
-- map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- New file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Clear search with <esc>
map({ "n", "i" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Move Lines
map("n", "<a-j>", "<cmd>m .+1<cr>==", { desc = "Move line(s) down", noremap = true })
map("n", "<a-k>", "<cmd>m .-2<cr>==", { desc = "Move line(s) up", noremap = true })
map("i", "<a-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down", noremap = true })
map("i", "<a-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up", noremap = true })
map("v", "<a-j>", ":m '>+1<cr>gv=gv", { desc = "Move line(s) down", noremap = true })
map("v", "<a-k>", ":m '<-2<cr>gv=gv", { desc = "Move line(s) up", noremap = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<c-h>", "<c-w>h", { desc = "go to left window", noremap = false })
map("n", "<c-j>", "<c-w>j", { desc = "go to lower window", noremap = false })
map("n", "<c-k>", "<c-w>k", { desc = "go to upper window", noremap = false })
map("n", "<c-l>", "<c-w>l", { desc = "go to right window", noremap = false })

-- Windows
map("n", "<leader>ww", "<c-w>p", { desc = "Other window", remap = true })
map("n", "<leader>wd", "<c-w>c", { desc = "Delete window", remap = true })
map("n", "<leader>w-", "<c-w>s", { desc = "Split window below", remap = true })
map("n", "<leader>w|", "<c-w>v", { desc = "Split window right", remap = true })
map("n", "<leader>-", "<c-w>s", { desc = "Split window below", remap = true })
map("n", "<leader>|", "<c-w>v", { desc = "Split window right", remap = true })

-- Move / arrange windows
map("n", "<leader>wh", "<c-w>H", { desc = "Move window left", remap = true })
map("n", "<leader>wj", "<c-w>J", { desc = "Move window down", remap = true })
map("n", "<leader>wk", "<c-w>K", { desc = "Move window up", remap = true })
map("n", "<leader>wl", "<c-w>L", { desc = "Move window right", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<c-up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<c-down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<c-left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<c-right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<c-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<c-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<c-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<c-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- Toggle options
map("n", "<leader>uf", "<cmd>FormatToggle<cr>", { desc = "Auto Format (global)" })
map("n", "<leader>uF", "<cmd>FormatToggle!<cr>", { desc = "Auto Format (buffer)" })

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
-- map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })
-- map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
-- map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
-- local diagnostic_goto = function(next, severity)
--   local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
--   severity = severity and vim.diagnostic.severity[severity] or nil
--   return function()
--     go({ severity = severity })
--   end
-- end
-- map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Show diagnostics" })
-- map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
-- map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
-- map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
-- map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
-- map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
-- map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
