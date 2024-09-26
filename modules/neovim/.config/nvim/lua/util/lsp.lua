local M = {}

-- Get an lsp server configuration
function M.get_config(server)
  local configs = require("lspconfig.configs")
  return rawget(configs, server)
end

-- Disable an lsp server
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
