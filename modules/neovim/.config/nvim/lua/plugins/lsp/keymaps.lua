local M = {}

function M.get()
  local keymaps = {
    { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
    -- {
    --   "gd",
    --   function()
    --     require("telescope.builtin").lsp_definitions({ reuse_win = true })
    --   end,
    --   desc = "Goto Definition",
    --   has = "definition",
    -- },
    -- { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
    -- { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
    -- {
    --   "gI",
    --   function()
    --     require("telescope.builtin").lsp_implementations({ reuse_win = true })
    --   end,
    --   desc = "Goto Implementation",
    -- },
    -- {
    --   "gy",
    --   function()
    --     require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
    --   end,
    --   desc = "Goto T[y]pe Definition",
    -- },
    -- { "K", vim.lsp.buf.hover, desc = "Hover" },
    -- { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
    -- { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
    -- { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
    -- { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
    -- {
    --   "<leader>cC",
    --   vim.lsp.codelens.refresh,
    --   desc = "Refresh & Display Codelens",
    --   mode = { "n" },
    --   has = "codeLens",
    -- },
    -- {
    --   "<leader>cA",
    --   function()
    --     vim.lsp.buf.code_action({
    --       context = {
    --         only = {
    --           "source",
    --         },
    --         diagnostics = {},
    --       },
    --     })
    --   end,
    --   desc = "Source Action",
    --   has = "codeAction",
    -- },
  }

  return keymaps
end

return M
