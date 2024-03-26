local M = {}

function M.get()
  local keymaps = {
    --
    -- From lsp-zero
    --
    -- map('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename symbol')
    -- map('n', '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', 'Format file')
    -- map('x', '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', 'Format selection')
    -- map('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Execute code action')
    -- if vim.lsp.buf.range_code_action then
    --   map('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>', 'Execute code action')
    -- else
    --   map('x', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Execute code action')
    -- end
    -- map('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', 'Show diagnostic')
    -- map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'Previous diagnostic')
    -- map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', 'Next diagnostic')
    --
    -- custom
    --
    -- Opens a popup that displays documentation about the word under your cursor
    --  See `:help K` for why this keymap.
    { "K", vim.lsp.buf.hover, { desc = "Hover Documentation" } },

    -- Show the signature help for the word under your cursor.
    { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },

    -- Show the signature help for the word under your cursor (insert mode).
    { "<C-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    --    <cmd>lua vim.lsp.buf.declaration()
    { "gd", require("telescope.builtin").lsp_definitions, { desc = "[G]oto [D]efinition" } },

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    --    <cmd>lua vim.lsp.buf.declaration()<cr>
    { "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" } },

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    --    <cmd>lua vim.lsp.buf.implementation()<cr>
    { "gi", require("telescope.builtin").lsp_implementations, { desc = "[G]oto [I]mplementation" } },

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    --    <cmd>lua vim.lsp.buf.type_definition()<cr>
    { "go", require("telescope.builtin").lsp_type_definitions, { desc = "Type [D]efinition" } },

    -- Find references for the word under your cursor.
    --   <cmd>lua vim.lsp.buf.references()<cr>
    { "gr", require("telescope.builtin").lsp_references, { desc = "[G]oto [R]eferences" } },

    -- Shwo signature help for the word under your cursor.
    -- <cmd>lua vim.lsp.buf.signature_help()<cr>
    { "gs", vim.lsp.buf.signature_help, { desc = "Signiture Function Help" } },

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    { "<leader>ds", require("telescope.builtin").lsp_document_symbols, { desc = "[D]ocument [S]ymbols" } },

    -- Fuzzy find all the symbols in your current workspace.
    --  Similar to document symbols, except searches over your entire project.
    { "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, { desc = "[W]orkspace [S]ymbols" } },

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    { "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" } },

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    { "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" } },

    -- Execute a codelens action
    { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },

    -- Show the LSP info for the current buffer.
    { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
  }

  return keymaps
end

return M
