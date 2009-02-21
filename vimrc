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

filetype plugin on
filetype plugin indent on " Enable filetype-specific indenting and plugins



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:nmap <F2> :NERDTreeToggle<cr>


" http://github.com/fabiokung/vimfiles/blob/6723ec056282f4d2d66d214c921111f57fa48035/vimrc
let g:browser = 'open '
" Open the Ruby ApiDock page for the word under cursor, in a new Firefox tab
function! OpenRubyDoc(keyword)
  let url = 'http://apidock.com/ruby/'.a:keyword
  exec '!'.g:browser.' '.url.' &'
endfunction
noremap RB :call OpenRubyDoc(expand('<cword>'))<CR>
 
" Open the Rails ApiDock page for the word under cursos, in a new Firefox tab
function! OpenRailsDoc(keyword)
  let url = 'http://apidock.com/rails/'.a:keyword
  exec '!'.g:browser.' '.url.' &'
endfunction
noremap RR :call OpenRailsDoc(expand('<cword>'))<CR>

