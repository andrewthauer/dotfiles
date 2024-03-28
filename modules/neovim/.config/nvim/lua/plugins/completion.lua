return {
  -- auto completion
  -- https://github.com/hrsh7th/nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- source for nvim lsp
      "hrsh7th/cmp-nvim-lsp-signature-help", -- signature help
      "hrsh7th/cmp-buffer", -- source for text in buffer
      "hrsh7th/cmp-path", -- source for file system paths
      "hrsh7th/cmp-emoji", -- emoji
    },
    ---@diagnostic disable-next-line: unused-local
    opts = function(_, opts)
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      return {
        -- make the first item in completion menu always be selected
        preselect = "item",
        completion = {
          completeopt = "menu,menuone,preview,noinsert",
        },
        formatting = {
          -- order of completion fields
          -- fields = { "abbr", "kind", "menu" },
          -- show icons in completion menu
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
            symbol_map = { Copilot = "" },
          }),
        },
        -- completion sources ordering
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "path" },
          { name = "emoji" },
        }, {
          { name = "buffer" },
        }),
        experimental = {
          -- TODO: figure out how to make ghost text less bright
          -- ghost_text = { hl_group = "CmpGhostText" },
        },
        -- key mappings
        mapping = cmp.mapping.preset.insert({
          --
          -- The following are nvim-cmp default keybindings ===
          --
          -- confirms selection
          ["<C-y>"] = cmp.mapping.confirm({ select = false }),
          -- cancels the completion
          ["<C-e>"] = cmp.mapping.abort(),
          -- navigate to the next item on the list
          ["<Down>"] = cmp.mapping.select_next_item({ behavior = "select" }),
          -- navigate to the previous item on the list
          ["<Up>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
          -- go to the previous item in the completion menu, or trigger completion menu
          ["<C-n>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_next_item({ behavior = "insert" })
            else
              cmp.complete()
            end
          end),
          -- Go to the next item in the completion menu, or trigger completion menu
          ["<C-p>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item({ behavior = "insert" })
            else
              cmp.complete()
            end
          end),
          --
          -- Everything following are custom keybindings
          --
          -- Scroll up and down the documentation window
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected item
          ["<CR>"] = cmp.mapping.confirm({ behavior = "replace", select = false }),
          -- Manually invoke completions
          ["<C-Space>"] = cmp.mapping.complete(),
          -- Navigate the completion list using vim natural up/down
          ["<C-k>"] = cmp.mapping.select_next_item(),
          ["<C-j>"] = cmp.mapping.select_prev_item(),
          -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          -- Do no accept completion when. Allows for explicit new line.
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
        }),
        -- enabled = function()
        --   -- disable completion in comments
        --   local context = require("cmp.config.context")
        --   -- keep command mode completion enabled when cursor is in a comment
        --   if vim.api.nvim_get_mode().mode == "c" then
        --     return true
        --   else
        --     return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
        --   end
        -- end,
      }
    end,
    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
      local cmp = require("cmp")

      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end

      cmp.setup(opts)
    end,
  },

  -- lsp pictograms
  -- https://github.com/onsails/lspkind.nvim
  {
    "onsails/lspkind.nvim",
    opts = {},
    config = function()
      require("lspkind").init()
    end,
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
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    keys = {
      {
        "<Tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<Tab>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "s",
      },
      {
        "<S-Tab>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" },
      },
    },
  },
}
