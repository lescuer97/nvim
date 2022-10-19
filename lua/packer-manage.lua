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
} -- config for lsp
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'simrat39/rust-tools.nvim'
  use 'jose-elias-alvarez/typescript.nvim'
  use 'hrsh7th/vim-vsnip'
  use '/tpope/vim-fugitive'
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}
end
  )
