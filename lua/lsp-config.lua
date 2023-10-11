local nnoremap = require("keymap").nnoremap
local inoremap = require("keymap").inoremap

vim.opt.signcolumn = 'yes'

local lsp_zero = require('lsp-zero')

lsp_zero.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = ''
})

vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = {
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})



lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_setup({
        buffer = bufnr,
        preserve_mappings = false,
    })
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

require('mason').setup({})


require('mason-lspconfig').setup({
  ensure_installed = {
    'tsserver',
    'lua_ls',
    'rust_analyzer',
    'denols',
    'cssls',
    'html',
    'gopls',
    },
handlers = {
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,

    rust_analyzer = function()
        require('lspconfig').rust_analyzer.setup({
          capabilities = lsp_zero.get_capabilities(),
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                features = { "jwt", "totp" },
              },
              procMacro = {
                enable = true,
              },
            },
          },
        })
    end,

    denols = function ()
        require('lspconfig').denols.setup({
            capabilities = lsp_zero.get_capabilities(),
            root_dir = require('lspconfig.util').root_pattern("deno.json", "deno.jsonc"),
        })
    end,

    elmls = function ()
        require('lspconfig').elmls.setup({
            capabilities = lsp_zero.get_capabilities(),
            root_dir = require('lspconfig.util').root_pattern("elm.json", "elm.js"),
        })
    end,

    svelte = function ()
        require('lspconfig').svelte.setup({
            capabilities = lsp_zero.get_capabilities(),
            root_dir = require('lspconfig.util').root_pattern("svelte.config.js", "package.json", "svelte.config.cjs", "svelte.config.mjs", "svelte.config.ts"),
        })
    end,

    tsserver = function ()
        require('lspconfig').tsserver.setup({
             capabilities = lsp_zero.get_capabilities(),
             root_dir = require('lspconfig.util').root_pattern('package.json')
        })
    end
  },
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_action = lsp_zero.cmp_action()

require('luasnip.loaders.from_vscode').lazy_load()

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

cmp.setup({
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
    {name = 'buffer', keyword_length = 2},
    {name = 'luasnip', keyword_length = 2},
  },
  formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = false }),
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<Tab>'] = cmp_action.tab_complete(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
})
})

