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
  branch = 'v3.x',
  requires = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {                                      -- Optional
      'williamboman/mason.nvim',
      run = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},         -- Required
    {'hrsh7th/cmp-nvim-lsp'},     -- Required
    {'hrsh7th/cmp-buffer'},       -- Optional
    {'hrsh7th/cmp-path'},         -- Optional
    {'saadparwaiz1/cmp_luasnip'}, -- Optional
    {'hrsh7th/cmp-nvim-lua'},     -- Optional

    -- Snippets
    {'L3MON4D3/LuaSnip'},             -- Required
    {'rafamadriz/friendly-snippets'}, -- Optional
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


--tmux 
use 'christoomey/vim-tmux-navigator'


end
)
