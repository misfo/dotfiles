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

set foldmethod=syntax
set foldlevelstart=99

" highlight trailing whitespace only when it's not before the insert cursor
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
autocmd BufWinEnter,InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhiteSpace /\s\+\%#\@<!$/


let NERDTreeChDirMode=2

" changes the present working directory only if passed a directory
function! s:chDirIfDir(dir)
  if a:dir != '' && isdirectory(a:dir)
    exec 'cd %:p:h'
  endif
endfunction

" cd into the directory if a directory is edited (e.g. vim /usr/bin,
" :e some/dir)
au BufEnter,VimEnter * call s:chDirIfDir(expand("<amatch>"))



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>d :NERDTreeToggle<CR>


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

