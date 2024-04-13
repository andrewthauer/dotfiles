-- User commands go here

-- close all buffers except the current one
vim.api.nvim_create_user_command("BufCloseOthers", function()
  require("util").close_other_buffers()
end, {})

-- wipe all named registers
vim.api.nvim_create_user_command("RegClear", function()
  require("util").clear_registers()
end, {})

-- update all plugins
vim.api.nvim_create_user_command("UpdateAllPlugins", function()
  require("util").update_all_plugins()
end, {})

-- lsp code actions
vim.api.nvim_create_user_command("LspCodeActions", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local params = vim.lsp.util.make_range_params()

  params.context = {
    triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
    diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
  }

  ---@diagnostic disable-next-line: unused-local
  vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function(error, results, context, config)
    -- results is an array of lsp.CodeAction
    print("Code Actions: " .. vim.inspect(results))
  end)
end, {})
