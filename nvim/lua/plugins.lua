-- bootstrap packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  --Language Integration
  use 'sheerun/vim-polyglot'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-vsnip'
  use 'simrat39/rust-tools.nvim'
  use 'folke/lua-dev.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ":TSUpdate"}
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'mhinz/vim-crates'
  use 'fladson/vim-kitty'
  use 'elkowar/yuck.vim'
  use 'gentoo/gentoo-syntax'

  -- Text Manipulation
  use 'machakann/vim-sandwich'
  use 'matze/vim-move'
  use 'christoomey/vim-tmux-navigator'
  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-commentary'

  -- Navigation
  use {
    'junegunn/fzf.vim',
    requires = { 'junegunn/fzf', run = "./install --bin" };
  }
  use { 'kevinhwang91/nvim-bqf', ft = 'qf' }
  use 'abecodes/tabout.nvim'

  -- Util
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
  }
  use 'tpope/vim-repeat'
  use 'jghauser/mkdir.nvim'
  use 'svermeulen/vim-cutlass'
  use 'nvim-lualine/lualine.nvim'
  use 'arkav/lualine-lsp-progress'
  use 'sainnhe/sonokai'
  use 'andweeb/presence.nvim'
  use 'p00f/nvim-ts-rainbow'
  use 'rmagatti/auto-session'
  use 'stevearc/dressing.nvim'
  use 'axieax/urlview.nvim'

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end

end)

require("plugins.lsp")
require("plugins.config")
require("plugins.treesitter")
require("plugins.dashboard")
