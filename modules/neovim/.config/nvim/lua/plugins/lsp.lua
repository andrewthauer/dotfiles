return {
  -- configurations for nvim lsp
  -- https://github.com/neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/neodev.nvim", opts = {} },
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
    },
    opts = {
      ensure_installed = {
        "docker_compose_language_service",
        "dockerls",
        "denols",
        "gopls",
        "helm_ls",
        -- "jsonls",
        "lua_ls",
        "marksman",
        "pyright",
        "ruby_ls",
        "rust_analyzer",
        "solargraph",
        -- "taplo", -- toml
        "tsserver",
        "yamlls",
      },
    },
    keys = {},
    ---@diagnostic disable-next-line: unused-local
    config = function(_, opts)
      local lsp_zero = require("lsp-zero")
      local lsp_util = require("util.lsp")

      ---@diagnostic disable-next-line: unused-local
      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        lsp_zero.default_keymaps({ buffer = bufnr })
        -- custom key maps
        -- lsp.set_keymaps(require("plugins.lsp.keymaps").get())
      end)

      -- format on save
      -- lsp_zero.format_on_save({
      --   format_opts = {
      --     async = false,
      --     timeout_ms = 10000,
      --   },
      --   servers = {
      --     ["tsserver"] = { "javascript", "typescript" },
      --     ["rust_analyzer"] = { "rust" },
      --   },
      -- })

      -- to learn how to use mason.nvim with lsp-zero
      -- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
      -- require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = opts.ensure_installed,
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
          end,
        },
      })

      -- avoid conflicts with denols & tsserver
      if lsp_util.get_config("denols") and lsp_util.get_config("tsserver") then
        local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
        lsp_util.disable("tsserver", is_deno)
        lsp_util.disable("denols", function(root_dir)
          return not is_deno(root_dir)
        end)
      end
    end,
  },

  -- Neovim's LSP client with minimum effort
  -- https://lsp-zero.netlify.app
  -- https://github.com/VonHeikemen/lsp-zero.nvim
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependenciens = {
      "nvim-cmp",
      ---@diagnostic disable-next-line: unused-local
      opts = function(_, opts)
        ---@diagnostic disable-next-line: unused-local
        local cmp_action = require("lsp-zero").cmp_action()
        -- local mapping = {
        --   -- basic completions for Neovim's lua api
        --   ["<C-f>"] = cmp_action.luasnip_jump_forward(),
        --   ["<C-b>"] = cmp_action.luasnip_jump_backward(),
        --   -- enable SuperTab
        --   ["<Tab>"] = cmp_action.luasnip_supertab(),
        --   ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
        --   -- regular tab
        --   -- ["<Tab>"] = cmp_action.tab_complete(),
        --   -- ["<S-Tab>"] = cmp_action.select_prev_or_fallback(),
        -- }
        -- for _, key in ipairs(mapping) do
        --   table.insert(opts.mapping, key)
        -- end
      end,
    },
  },
}
