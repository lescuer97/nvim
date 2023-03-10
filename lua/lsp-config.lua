local nnoremap = require("keymap").nnoremap
local inoremap = require("keymap").inoremap

local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
   'lua_ls',
    'rust_analyzer',
    'denols',
    'cssls',
    'html',
    'gopls',

})

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
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
  root_dir = require('lspconfig.util').root_pattern("elm.json", "elm.js"),
})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    nnoremap("gD", function() vim.lsp.buf.declaration() end, opts)

    nnoremap("gd", function() vim.lsp.buf.definition() end, opts)
    -- nnoremap("<leader>gd", ':vsplit | lua vim.lsp.buf.definition()<CR>')
    -- nnoremap("gd", function()vim.tab.split(); vim.lsp.buf.definition() end, opts)
    nnoremap("K", function() vim.lsp.buf.hover() end, opts)
    nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    nnoremap("<leader>vd", function() vim.diagnostic.open_float() end, opts)
    nnoremap("[d", function() vim.diagnostic.goto_next() end, opts)
    nnoremap("]d", function() vim.diagnostic.goto_prev() end, opts)
    nnoremap("<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    nnoremap("<leader>vco", function() vim.lsp.buf.code_action({
        filter = function(code_action)
            if not code_action or not code_action.data then
                return false
            end

            local data = code_action.data.id
            return string.sub(data, #data - 1, #data) == ":0"
        end,
        apply = true
    }) end, opts)
    nnoremap("<leader>vrr", function() vim.lsp.buf.references() end, opts)
    nnoremap("<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    inoremap("<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)


lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})


