return {
  -- auto completion
  -- https://github.com/hrsh7th/nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- source for nvim lsp
      "hrsh7th/cmp-buffer",   -- source for text in buffer
      "hrsh7th/cmp-path",     -- source for file system paths
    },
    opts = function()
      local cmp = require("cmp")
      return {
        completion = {
          completeopt = "menu,menuone,preview,noinsert",
        },
        -- mapping = cmp.mapping.preset.insert({
        --   ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        --   ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        --   ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        --   ["<C-f>"] = cmp.mapping.scroll_docs(4),
        --   ["<C-Space>"] = cmp.mapping.complete(),
        --   ["<C-e>"] = cmp.mapping.abort(),
        --   ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        --   ["<S-CR>"] = cmp.mapping.confirm({
        --     behavior = cmp.ConfirmBehavior.Replace,
        --     select = true,
        --   }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        --   ["<C-CR>"] = function(fallback)
        --     cmp.abort()
        --     fallback()
        --   end,
        -- }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- from lsp
          { name = "path" },     -- file system paths
        }, {
          { name = "buffer" },   -- text within current buffer
        })
      }
    end,
    -- config = function(_, opts)
    --   for _, source in ipairs(opts.sources) do
    --     source.group_index = source.group_index or 1
    --   end
    --   require("cmp").setup(opts)
    -- end,
  },

  -- snippets
  -- https://github.com/L3MON4D3/LuaSnip
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      {
        "nvim-cmp",
        dependencies = {
          "saadparwaiz1/cmp_luasnip",
        },
        opts = function(_, opts)
          opts.snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          }
          table.insert(opts.sources, { name = "luasnip" })
        end,
      },
    },
    -- opts = {
    --   history = true,
    --   delete_check_events = "TextChanged",
    -- },
    -- -- stylua: ignore
    -- keys = {
    --   {
    --     "<tab>",
    --     function()
    --       return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
    --     end,
    --     expr = true,
    --     silent = true,
    --     mode = "i",
    --   },
    --   { "<tab>", function() require("luasnip").jump(1) end,  mode = "s" },
    --   { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    -- },
  },

  -- comments
  -- https://github.com/echasnovski/mini.comment
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    -- opts = {
    --   options = {
    --     custom_commentstring = function()
    --       return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
    --     end,
    --   },
    -- },
  },
}
