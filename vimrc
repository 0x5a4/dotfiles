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
Plug 'ryanoasis/vim-devicons'
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
"fix my tabs
set tabstop=2 shiftwidth=2 expandtab

"colorscheme
silent! colorscheme sonokai

set nocp
set number
syntax enable

"key mappings
inoremap jk <esc> 
inoremap <esc> <nop>
"stop using them please
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>
