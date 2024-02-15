-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.5',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v3.x',
	  requires = {
		  --- Uncomment the two plugins below if you want to manage the language servers from neovim
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'L3MON4D3/LuaSnip'},
	  }
  }
  -- use('bluz71/vim-nightfly-colors', { as = 'nightfly' })
  -- use('mhartington/oceanic-next')
  -- use('Shatur/neovim-ayu')
  -- use('ray-x/aurora')
  -- use { 'kartikp10/noctis.nvim', requires = { 'rktjmp/lush.nvim' } }
  -- use "Alexis12119/nightly.nvim"
  -- use "polirritmico/monokai-nightasty.nvim"
  -- use "bratpeki/truedark-vim"
  -- use "barrientosvctor/abyss.nvim"
  -- use({
  --     'Allianaab2m/penumbra.nvim',
  --     config = function()
  --         require('penumbra').setup()
  --         vim.api.nvim_command('colorscheme penumbra')
  --     end
  -- })
  use("folke/tokyonight.nvim")
  use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
  use('preservim/nerdtree')
  use('stevearc/conform.nvim')
end)
