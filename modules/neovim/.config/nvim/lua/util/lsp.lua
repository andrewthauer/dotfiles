local M = {}

---@diagnostic disable-next-line: duplicate-doc-alias
---@alias lsp.Client.filter {id?: number, bufnr?: number, name?: string, method?: string, filter?:fun(client: lsp.Client):boolean}

function M.get_config(server)
  local configs = require("lspconfig.configs")
  return rawget(configs, server)
end

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

return M
