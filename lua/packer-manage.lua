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

  use 'neovim/nvim-lspconfig'
  use 'simrat39/symbols-outline.nvim'
  -- golang config
  use 'ray-x/go.nvim'
  use 'ray-x/guihua.lua' -- recommanded if need floating window support
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/vim-vsnip'
  use 'tpope/vim-fugitive'
  use 'RishabhRD/nvim-lsputils'
  use 'RishabhRD/popfix'
      use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}

end
  )
