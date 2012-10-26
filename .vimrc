syntax on

" tab options
set sts=2
set shiftwidth=2
set expandtab

set backspace=eol,start,indent

" searching options
set incsearch
set hlsearch

" command line options
set showcmd
set ruler

" allow mouse for all uses
set mouse=a

filetype plugin on
filetype plugin indent on " Enable filetype-specific indenting and plugins

" file extension associations
au BufNewFile,BufRead *.dtm setf clojure
au BufNewFile,BufRead *.edn setf clojure

" pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

" ctrlp.vim
let g:ctrlp_extensions = ['tag', 'buffertag']
let g:ctrlp_working_path_mode = 0
