let mapleader="-"

"Install vim-plug
let s:data_dir = "~/.vim"
if empty(glob(s:data_dir.'/autoload/plug.vim'))
  silent execute '!curl -fLo '.s:data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Plugins {{{
call plug#begin(s:data_dir.'/plugged')

Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'fladson/vim-kitty'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-crates'
Plug 'terryma/vim-multiple-cursors'
Plug 'matze/vim-move'
Plug 'svermeulen/vim-cutlass'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'christoomey/vim-tmux-navigator'
if executable('fzf') 
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
endif
"god this is so unnecessary
if has('python3')
  Plug 'vimsence/vimsence'
endif
"Colorscheme
Plug 'sainnhe/sonokai', {'do': ':colorscheme sonokai'}
"Auto completion
if has('python3') && executable('cmake')
  Plug 'ycm-core/YouCompleteMe'
endif

call plug#end()
"}}}

"Plugin Configuration {{{
if has('nvim')
  "vim-crates things
  autocmd BufRead Cargo.toml call crates#toggle()
  "true color support
  set termguicolors
endif

"airline configuration
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme = 'sonokai'

"YouCompleteMe configuration
let g:ycm_autoclose_preview_window_after_completion = 1
nnoremap <F2> :YcmCompleter FixIt<CR>
nnoremap <c-F> :YcmCompleter Format<CR>

"vimsence config
if has('nvim')
  let g:vimsence_small_text = 'NeoVim'   
  let g:vimsence_small_image = 'neovim'  
endif

"vim-move interferes with my .tmux.conf
let g:move_key_modifier = 'C'

"fzf 
nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"

"NERDTree
nnoremap <silent> <leader>n :NERDTree<CR>

"Vim tmux navigator
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 2
nnoremap <silent> <A-l> :TmuxNavigateRight<CR>
nnoremap <silent> <A-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <A-j> :TmuxNavigateDown<CR>
nnoremap <silent> <A-k> :TmuxNavigateUp<CR>
nnoremap <silent> <A-,> :TmuxNavigatePrevious<CR>

"}}}

"Variables {{{
"fix my tabs
set tabstop=4 shiftwidth=4 expandtab

"colorscheme
silent! colorscheme sonokai

"basic shit
syntax enable
set nocp
set number
set autoread
set smartcase
set nohlsearch 
set hidden
set scrolloff=10
set splitright

"folding
set foldenable
set foldmethod=marker

"undo preserve
set undofile
set undodir=~/.vim/undodir/
"}}}

"Keybinds {{{
noremap B be
noremap ° ^

"stop using them please
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Right> <nop>
noremap <Left> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Right> <nop>
inoremap <Left> <nop>
"fucking qwertz
nnoremap ü {
vnoremap ü {
nnoremap ä }
vnoremap ä }
"ctrl-u -> change word to capital letters
inoremap <c-u> <esc>bveUea
"i dont need this
noremap Q <nop>
nnoremap <F10> :set foldmethod=indent<CR>

"buffer navigation
nnoremap <silent> <leader>, :bnext<CR>
nnoremap <silent> <leader>m :bprev<CR>
nnoremap <silent> <leader>bd :bd<CR>

"cut -> works because of vim cutlass
nnoremap X d
xnoremap X d
nnoremap XX dd
xnoremap X D
"}}}

"Random {{{
"For emails
au BufRead /tmp/neomutt-* set tw=72
"}}}

