local lsp_defaults = {
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
    ),
    on_attach = function(client, bufnr)
        vim.api.nvim_exec_autocmds('User', {pattern = 'LspAttached'})
    end
}
local lspconfig = require('lspconfig')
lspconfig.util.default_config = vim.tbl_deep_extend(
'force',
lspconfig.util.default_config,
lsp_defaults
)
local opts = {
    tools = { -- rust-tools options
    autoSetHints = true,
    inlay_hints = {
        show_parameter_hints = true,
        parameter_hints_prefix = "",
        other_hints_prefix = "",
    },
},
disable_commands = false, -- prevent the plugin from creating Vim commands
debug = false, -- enable debug logging for commands
go_to_source_definition = {
    fallback = true, -- fall back to standard LSP definition on failure
},
}
require('rust-tools').setup(opts)
require("typescript").setup(opts)

--GO LSP Setup
require('go').setup(opts)

-- " Setup Completion
--:" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local cmp = require'cmp'
cmp.setup({
    -- Enable LSP snippets
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Add tab support
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },

    -- Installed sources
    sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'path' },
        { name = 'buffer' },
    },
})
-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.denols.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
}
lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern("package.json"),
}
-- lsputils config
--
local bufnr = vim.api.nvim_buf_get_number(0)

vim.lsp.handlers['textDocument/codeAction'] = function(_, _, actions)
    require('lsputil.codeAction').code_action_handler(nil, actions, nil, nil, nil)
end

vim.lsp.handlers['textDocument/references'] = function(_, _, result)
    require('lsputil.locations').references_handler(nil, result, { bufnr = bufnr }, nil)
end

vim.lsp.handlers['textDocument/definition'] = function(_, method, result)
    require('lsputil.locations').definition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
end

vim.lsp.handlers['textDocument/declaration'] = function(_, method, result)
    require('lsputil.locations').declaration_handler(nil, result, { bufnr = bufnr, method = method }, nil)
end

vim.lsp.handlers['textDocument/typeDefinition'] = function(_, method, result)
    require('lsputil.locations').typeDefinition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
end

vim.lsp.handlers['textDocument/implementation'] = function(_, method, result)
    require('lsputil.locations').implementation_handler(nil, result, { bufnr = bufnr, method = method }, nil)
end

vim.lsp.handlers['textDocument/documentSymbol'] = function(_, _, result, _, bufn)
    require('lsputil.symbols').document_handler(nil, result, { bufnr = bufn }, nil)
end

vim.lsp.handlers['textDocument/symbol'] = function(_, _, result, _, bufn)
    require('lsputil.symbols').workspace_handler(nil, result, { bufnr = bufn }, nil)
end
