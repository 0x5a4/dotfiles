-- bootstrap packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path
  }
  vim.cmd [[packadd packer.nvim]]
end

local packer = require("packer")

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
    working_sym = ''
  }
}


-- Install plugins
packer.startup(function(use)

  local configmap = require("config")

  use 'wbthomason/packer.nvim'

  -- Syntax Highlighting
  use 'sheerun/vim-polyglot'
  use 'neovim/nvim-lspconfig'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    config = configmap["treesitter"]
  }
  use 'fladson/vim-kitty'
  use 'elkowar/yuck.vim'
  use 'gentoo/gentoo-syntax'
  use 'p00f/nvim-ts-rainbow'

  -- Completion
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
  use { 'mhinz/vim-crates', config = configmap["vim-crates"] }

  use { 'lewis6991/spellsitter.nvim', config = configmap["spellsitter"] }
  use {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'ftilde/vim-ugdb'

  -- Text Manipulation
  use 'tpope/vim-surround'
  use { 'matze/vim-move', config = configmap["vim-move"] }
  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-commentary'
  use 'rmagatti/alternate-toggler'
  use 'jbyuki/venn.nvim' -- Fancy graphdrawing
  use 'svermeulen/vim-cutlass'

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
  use 'jghauser/follow-md-links.nvim'
  use {
    'ggandor/leap.nvim',
    config = function()
      require("leap").set_default_keymaps()
    end
  }
  use 'wellle/targets.vim'
  use { 'gbprod/stay-in-place.nvim', config = function() require("stay-in-place").setup {} end }

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
  use 'axieax/urlview.nvim'
  use { 'numToStr/FTerm.nvim', config = configmap["fterm"] }
  use { 'norcalli/nvim-colorizer.lua', config = configmap["colorizer"] }
  use 'moll/vim-bbye'
  use { 'max397574/better-escape.nvim', config = configmap["better-escape"] }

  -- Aesthetics
  use { 'sainnhe/sonokai', config = function() vim.cmd("colorscheme sonokai") end }
  use { 'nvim-lualine/lualine.nvim', config = configmap["lualine"] }
  use { 'j-hui/fidget.nvim', config = configmap["fidget"] }
  use 'stevearc/dressing.nvim' --better looking vim.ui interfaces
  use { 'h-hg/numbers.nvim', config = function() require("numbers").setup {} end }

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end

end)
