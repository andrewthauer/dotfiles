---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    ---@diagnostic disable-next-line: redundant-parameter
    local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
  end
  return config
end

-- local function on_attach()
--   if vim.fn.filereadable(".vscode/launch.json") then
--     local dap_vscode = require("dap.ext.vscode")
--     dap_vscode.load_launchjs(nil, {
--       ["chrome"] = js_based_languages,
--       ["node"] = js_based_languages,
--       ["pwa-node"] = js_based_languages,
--       ["pwa-chrome"] = js_based_languages,
--       ["node-terminal"] = js_based_languages,
--     })
--   end
--   -- require("dap").continue()
--   require("dap").continue({ before = get_args })
-- end

return {
  {
    -- debug adapter protocol
    -- https://github.com/mfussenegger/nvim-dap
    "mfussenegger/nvim-dap",
    enabled = false,
    dependencies = {
      -- fancy UI for the debugger
      -- https://github.com/rcarriga/nvim-dap-ui
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        keys = {
          -- stylua: ignore start
          { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
          { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" } },
          -- stylua: ignore end
        },
        opts = {},
        config = function(_, opts)
          -- setup dap config by VsCode launch.json file
          -- require("dap.ext.vscode").load_launchjs()
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end
        end,
      },

      -- virtual text for the debugger
      -- https://github.com/theHamsta/nvim-dap-virtual-text
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },

      -- which key integration
      {
        "folke/which-key.nvim",
        optional = true,
        opts = {
          defaults = {
            ["<leader>d"] = { name = "+debug" },
          },
        },
      },

      -- mason.nvim integration
      -- https://github.com/jay-babu/mason-nvim-dap.nvim
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "mason-org/mason.nvim" },
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          automatic_installation = true,
          handlers = {},
          ensure_installed = {},
        },
      },
    },
    keys = {
      -- stylua: ignore start
      { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
      -- stylua: ignore end
    },
    ---@diagnostic disable-next-line: unused-local
    config = function(_, opts)
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      -- local Config = require("lazyvim.config")
      -- for name, sign in pairs(Config.icons.dap) do
      --   sign = type(sign) == "table" and sign or { sign }
      --   vim.fn.sign_define(
      --     "Dap" .. name,
      --     { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      --   )
      -- end

      -- setup dap config by VsCode launch.json file
      local js_based_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
      local vscode = require("dap.ext.vscode")
      local _filetypes = require("mason-nvim-dap.mappings.filetypes")
      local filetypes = vim.tbl_deep_extend("force", _filetypes, {
        ["chrome"] = js_based_languages,
        ["node"] = js_based_languages,
        ["pwa-node"] = js_based_languages,
        ["pwa-chrome"] = js_based_languages,
        ["node-terminal"] = js_based_languages,
      })
      local json = require("plenary.json")
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end
      vscode.load_launchjs(nil, filetypes) -- setup dap config by VsCode launch.json file
    end,
  },
}
