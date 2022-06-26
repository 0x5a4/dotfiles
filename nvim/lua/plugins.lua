-- bootstrap packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path
  }
end

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)

  local configmap = require("config")

  use 'wbthomason/packer.nvim'

  --Language Integration
  use 'sheerun/vim-polyglot'
  use 'neovim/nvim-lspconfig'
  use {
    'williamboman/nvim-lsp-installer',
    config = configmap["lspconfig"]
  }
  use { 'hrsh7th/nvim-cmp', config = configmap["nvim-cmp"] }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-path'
  use 'simrat39/rust-tools.nvim'
  use 'folke/lua-dev.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    config = configmap["treesitter"]
  }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use {
    'mhinz/vim-crates',
    config = configmap["vim-crates"]
  }
  use 'fladson/vim-kitty'
  use 'elkowar/yuck.vim'
  use 'gentoo/gentoo-syntax'
  use {
    'lewis6991/spellsitter.nvim',
    config = configmap["spellsitter"]
  }
  use 'jghauser/follow-md-links.nvim'
  use {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  }

  -- Text Manipulation
  use 'machakann/vim-sandwich'
  use { 'matze/vim-move', config = configmap["vim-move"] }
  use { 'christoomey/vim-tmux-navigator', config = configmap["vim-tmux"] }
  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-commentary'
  use 'rmagatti/alternate-toggler'

  -- Navigation
  use {
    'junegunn/fzf.vim',
    requires = { 'junegunn/fzf', run = "./install --bin" };
  }
  use { 'kevinhwang91/nvim-bqf', ft = 'qf' }
  use 'folke/todo-comments.nvim'

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
  use { 'nvim-lualine/lualine.nvim', config = configmap["lualine"] }
  use 'arkav/lualine-lsp-progress'
  use 'sainnhe/sonokai'
  use 'p00f/nvim-ts-rainbow'
  use 'stevearc/dressing.nvim' --better looking vim.ui interfaces
  use 'axieax/urlview.nvim'
  use { 'numToStr/FTerm.nvim', config = configmap["fterm"] }

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end

end)
