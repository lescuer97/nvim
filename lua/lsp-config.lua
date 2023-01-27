local nnoremap = require("keymap").nnoremap
local inoremap = require("keymap").inoremap

local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'sumneko_lua',
    'rust_analyzer',
    'denols',
    'cssls',
    'html',
    'gopls',

})

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

lsp.configure('tsserver', {
  single_file_support = false,
  root_dir = require('lspconfig.util').root_pattern('package.json')
})
lsp.configure('denols', {
  root_dir = require('lspconfig.util').root_pattern("deno.json", "deno.jsonc"),
})
lsp.configure('elmls', {
  root_dir = require('lspconfig.util').root_pattern("elm.json"),
})

lsp.on_attach(function(client, bufnr)
    -- local opts = {buffer = bufnr, remap = false}

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
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})


