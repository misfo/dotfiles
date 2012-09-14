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

" pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()