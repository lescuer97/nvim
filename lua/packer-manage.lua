-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself
    -- Hello
    use 'wbthomason/packer.nvim'
    use 'folke/tokyonight.nvim'
    -- Fuzzy finder 
    use { 'ibhagwan/fzf-lua',
    -- optional for icon support
    requires = { 'kyazdani42/nvim-web-devicons' }
}
-- lualine 
use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
}
-- config for lsp
use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'saadparwaiz1/cmp_luasnip'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-nvim-lua'},

        -- Snippets
        {'L3MON4D3/LuaSnip'},
        -- Snippet Collection (Optional)
        {'rafamadriz/friendly-snippets'},
    }
}
use 'simrat39/symbols-outline.nvim'
use 'ray-x/guihua.lua' -- recommanded if need floating window support
use 'L3MON4D3/LuaSnip' -- Snippets plugin
use 'hrsh7th/vim-vsnip'
use 'tpope/vim-fugitive'
use 'RishabhRD/popfix'
use 'nvim-lua/plenary.nvim'
use 'ThePrimeagen/harpoon'
use("nvim-treesitter/nvim-treesitter", {
    run = ":TSUpdate"
})
use {
    "nvim-treesitter/nvim-treesitter-context",
    requires = { "nvim-treesitter/nvim-treesitter" }, -- nvim-treesitter-context depends on nvim-treesitter
}
use {

    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}

-- COPILOT
use 'github/copilot.vim'


end
)
