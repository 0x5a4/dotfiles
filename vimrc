let mapleader="-"

"Install vim-plug
let s:data_dir = "~/.vim"
if empty(glob(s:data_dir.'/autoload/plug.vim'))
  silent execute '!curl -fLo '.s:data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Plugins
function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    execute '!'.s:data_dir.'/plugged/YouCompleteMe/install.py --rust-completer'
  endif
endfunction

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
"god this is so unnecessary
if has('python3') && executable('discord')
  Plug 'vimsence/vimsence'
endif
"Colorscheme
Plug 'sainnhe/sonokai', {'do':':colorscheme sonokai'}
"Auto completion
if has('python3') && executable('cmake')
  Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }
endif

call plug#end()

if has('nvim')
  "vim-crates things
  autocmd BufRead Cargo.toml call crates#toggle()
  if has('nvim')
    "true color support
    set termguicolors
  endif
endif

"airline configuration
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme = 'sonokai'

"YouCompleteMe configuration
let g:ycm_autoclose_preview_window_after_completion = 1

"vimsence config
if has('nvim')
  let g:vimsence_small_text = 'NeoVim'   
  let g:vimsence_small_image = 'neovim'  
endif
"fix my tabs
set tabstop=2 shiftwidth=2 expandtab

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
set foldenable

"undo preserve
set undofile
set undodir=~/.vim/undodir/
"random key mappings

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
"we HATE capital letters
nnoremap <silent> nt :NERDTree<CR>
"ctrl-u -> change word to capital letters
inoremap <c-u> <esc>bveUea
"utils for quitting
nnoremap <Leader>qq :qa<CR>
nnoremap <Leader>qw :wqa<CR>
"i dont need this
noremap Q <nop>
nnoremap <F10> :set foldmethod=indent<CR>

"buffer navigation
nnoremap <silent> , :bnext<CR>
nnoremap <silent> m :bprev<CR>
nnoremap <silent> <leader>bd :bd<CR>

"YouCompleteMe shortcuts
nnoremap <F2> :YcmCompleter FixIt<CR>
nnoremap <c-F> :YcmCompleter Format<CR>
