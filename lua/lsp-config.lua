local nnoremap = require("keymap").nnoremap
local inoremap = require("keymap").inoremap

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

local function config(_config)
    return vim.tbl_deep_extend("force", {
        on_attach = function()
            nnoremap("gD", function() vim.lsp.buf.declaration() end)

            nnoremap("gd", ':vsplit | lua vim.lsp.buf.definition()<CR>')
            -- nnoremap("gd", function()vim.tab.split(); vim.lsp.buf.definition() end)
            nnoremap("K", function() vim.lsp.buf.hover() end)
            nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
            nnoremap("<leader>vd", function() vim.diagnostic.open_float() end)
            nnoremap("[d", function() vim.diagnostic.goto_next() end)
            nnoremap("]d", function() vim.diagnostic.goto_prev() end)
            nnoremap("<leader>vca", function() vim.lsp.buf.code_action() end)
            nnoremap("<leader>vco", function() vim.lsp.buf.code_action({
                filter = function(code_action)
                    if not code_action or not code_action.data then
                        return false
                    end

                    local data = code_action.data.id
                    return string.sub(data, #data - 1, #data) == ":0"
                end,
                apply = true
            }) end)
            nnoremap("<leader>vrr", function() vim.lsp.buf.references() end)
            nnoremap("<leader>vrn", function() vim.lsp.buf.rename() end)
            inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
        end,
    }, _config or {})
end

-- luasnip setup
local luasnip = require 'luasnip'

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

require("symbols-outline").setup(opts)

-- " Setup Completion
--:" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local cmp = require'cmp'
cmp.setup({
    -- Enable LSP snippets
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
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
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.denols.setup(config({
    -- capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
}))

lspconfig.tsserver.setup(config({
    -- capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern("package.json"),
}))
lspconfig.rust_analyzer.setup(config({
    
    -- capabilities = capabilities,
   cmd = { "rustup", "run", "nightly", "rust-analyzer" },
    --[[
    settings = {
        rust = {
            unstable_features = true,
            build_on_save = false,
            all_features = true,
        },
    }
    --]]
}))
-- lsputils config
--
-- local bufnr = vim.api.nvim_buf_get_number(0)

-- vim.lsp.handlers['textDocument/codeAction'] = function(_, _, actions)
--     require('lsputil.codeAction').code_action_handler(nil, actions, nil, nil, nil)
-- end
--
-- vim.lsp.handlers['textDocument/references'] = function(_, _, result)
--     require('lsputil.locations').references_handler(nil, result, { bufnr = bufnr }, nil)
-- end
--
-- vim.lsp.handlers['textDocument/definition'] = function(_, method, result)
--     require('lsputil.locations').definition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
-- end
--
-- vim.lsp.handlers['textDocument/declaration'] = function(_, method, result)
--     require('lsputil.locations').declaration_handler(nil, result, { bufnr = bufnr, method = method }, nil)
-- end
--
-- vim.lsp.handlers['textDocument/typeDefinition'] = function(_, method, result)
--     require('lsputil.locations').typeDefinition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
-- end
--
-- vim.lsp.handlers['textDocument/implementation'] = function(_, method, result)
--     require('lsputil.locations').implementation_handler(nil, result, { bufnr = bufnr, method = method }, nil)
-- end
--
-- vim.lsp.handlers['textDocument/documentSymbol'] = function(_, _, result, _, bufn)
--     require('lsputil.symbols').document_handler(nil, result, { bufnr = bufn }, nil)
-- end
--
-- vim.lsp.handlers['textDocument/symbol'] = function(_, _, result, _, bufn)
--     require('lsputil.symbols').workspace_handler(nil, result, { bufnr = bufn }, nil)
-- end
