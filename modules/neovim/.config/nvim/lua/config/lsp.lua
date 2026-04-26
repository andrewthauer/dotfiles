-- LSP diagnostics and attach-time setup. Per-server settings live in plugins/lang/*.

vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "●" },
  severity_sort = true,
})

local function get_keymaps()
  -- stylua: ignore start
  return {
    { "g.", vim.lsp.buf.code_action, desc = "Code Action" },
    { "<F2>", vim.lsp.buf.rename, desc = "Rename symbol" },
    { "<leader>cL", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
    { "<leader>cU", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
    { "<leader>cI", "<cmd>LspInfo<cr>", desc = "LSP Info" },
  }
  -- stylua: ignore end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then return end
    local bufnr = event.buf

    if client:supports_method("textDocument/codeLens") then
      vim.lsp.codelens.refresh({ bufnr = 0 })
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        buffer = bufnr,
        callback = vim.lsp.codelens.refresh,
      })
    end

    require("util").map_keys({ keys = get_keymaps(), buffer = bufnr })
  end,
})
