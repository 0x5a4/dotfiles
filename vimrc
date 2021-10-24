"Install vim-plug
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


"Plugins
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'rust-lang/rust.vim'
"Colorscheme
Plug 'sainnhe/sonokai', {'do':':colorscheme sonokai'}

call plug#end()

set nocp
set number
syntax enable

if has('nvim') || has('termguicolors')
	"true color support
  set termguicolors
endif

"fix my tabs
set tabstop=2 shiftwidth=2 expandtab

"colorscheme
silent! colorscheme sonokai
