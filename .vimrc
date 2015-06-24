" tab options
set sts=2
set shiftwidth=2
set expandtab

" allow mouse for all uses
set mouse=a

" file extension associations
au BufNewFile,BufRead *.dtm setf clojure
au BufNewFile,BufRead *.edn setf clojure

" pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

" ctrlp.vim
let g:ctrlp_extensions = ['tag', 'buffertag']
let g:ctrlp_working_path_mode = 0
