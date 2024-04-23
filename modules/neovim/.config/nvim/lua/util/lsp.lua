local M = {}

---@diagnostic disable-next-line: duplicate-doc-alias
---@alias lsp.Client.filter {id?: number, bufnr?: number, name?: string, method?: string, filter?:fun(client: lsp.Client):boolean}

-- Common lsp attach hook function
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

  ---@diagnostic disable-next-line: undefined-field
  def.document_config.on_new_config = util.add_hook_before(def.document_config.on_new_config, function(config, root_dir)
    if cond(root_dir, config) then
      config.enabled = false
    end
  end)
end

-- Get a lust of clients based on the current buffer
---@param opts lsp.Client.filter
function M.get_clients(opts)
  local ret = {} ---@type lsp.Client[]

  if vim.lsp.get_clients then
    ret = vim.lsp.get_clients(opts)
  else
    ret = vim.lsp.get_active_clients(opts)

    if opts and opts.method then
      ---@param client lsp.Client
      ret = vim.tbl_filter(function(client)
        ---@diagnostic disable-next-line: redundant-parameter
        return client.supports_method(opts.method, { bufnr = opts.bufnr })
      end, ret)
    end
  end

  return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

return M
