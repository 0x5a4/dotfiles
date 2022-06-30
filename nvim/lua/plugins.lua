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
  use { 'lewis6991/spellsitter.nvim', config = configmap["spellsitter"] }
  use 'jghauser/follow-md-links.nvim'
  use {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  }

  -- Text Manipulation
  use 'tpope/vim-surround'
  use { 'matze/vim-move', config = configmap["vim-move"] }
  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-commentary'
  use 'rmagatti/alternate-toggler'

  -- Navigation
  use { 'christoomey/vim-tmux-navigator', config = configmap["vim-tmux"] }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = configmap["telescope"]
  }
  use('crispgm/telescope-heading.nvim')
  use {
    'folke/todo-comments.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = configmap["todo-comments"],
  }
  use { 'anuvyklack/hydra.nvim', config = configmap["hydra"] }
  use {
    'ggandor/leap.nvim',
    config = function()
      require("leap").set_default_keymaps()
    end
  }
  use 'wellle/targets.vim'

  -- Util
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = configmap["gitsigns"],
  }
  use 'tpope/vim-repeat'
  use 'jghauser/mkdir.nvim'
  use 'svermeulen/vim-cutlass'
  use 'p00f/nvim-ts-rainbow'
  use 'stevearc/dressing.nvim' --better looking vim.ui interfaces
  use 'axieax/urlview.nvim'
  use { 'numToStr/FTerm.nvim', config = configmap["fterm"] }
  use 'jbyuki/venn.nvim'
  use { 'norcalli/nvim-colorizer.lua', config = configmap["colorizer"] }
  use 'nyngwang/NeoNoName.lua'
  use { 'max397574/better-escape.nvim', config = configmap["better-escape"] }

  use { 'sainnhe/sonokai', config = function() vim.cmd("colorscheme sonokai") end }
  use { 'nvim-lualine/lualine.nvim', config = configmap["lualine"] }
  use 'arkav/lualine-lsp-progress'

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end

end)
