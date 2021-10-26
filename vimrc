"Install vim-plug
let s:data_dir = "~/.vim"
if empty(glob(s:data_dir.'/autoload/plug.vim'))
  silent execute '!curl -fLo '.s:data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Plugins
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
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
"Colorscheme
Plug 'sainnhe/sonokai', {'do':':colorscheme sonokai'}
"Auto completion
Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }

call plug#end()

if has('nvim') || has('termguicolors')
	"true color support
  set termguicolors
endif

"airline configuration
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme = 'sonokai'
"fix my tabs
set tabstop=2 shiftwidth=2 expandtab

"colorscheme
silent! colorscheme sonokai

set nocp
set number
syntax enable

"key mappings
let g:mapleader = '-'
"stop using them please
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Right> <nop>
noremap <Left> <nop>
"fucking qwertz
nnoremap ü (
vnoremap ü (
nnoremap ä )
vnoremap ä )
"we HATE capital letters
nnoremap nt :NERDTree<cr>
"ctrl-u -> change word to capital letters
inoremap <c-u> <esc>bveUea
"utils for quitting
nnoremap <Leader>QQ :qa<CR>
nnoremap <Leader>QW :wqa<CR>
"i dont need this
noremap Q <nop>
