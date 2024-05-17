local M = {}

-- Common lsp attach hook function
---@param client vim.lsp.Client
---@diagnostic disable-next-line: unused-local
function M.on_attach(client, bufnr, opts)
  opts = opts or {}

  if opts.inlay_hints and opts.inlay_hints.enabled then
    if client.supports_method("textDocument/inlayHint") then
      require("util").toggle.inlay_hints(bufnr, true)
    end
  end
end

-- Get an lsp server configuration
function M.get_config(server)
  local configs = require("lspconfig.configs")
  return rawget(configs, server)
end

-- Diable an lsp server
function M.disable(server, cond)
  local util = require("lspconfig.util")
  local def = M.get_config(server)

  def.document_config.on_new_config = util.add_hook_before(def.document_config.on_new_config, function(config, root_dir)
    if cond(root_dir, config) then
      config.enabled = false
    end
  end)
end

return M
