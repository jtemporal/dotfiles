set cc=80
set ts=4
set sw=4
set sts=4
set scrolloff=8
set sidescrolloff=15
set expandtab
set relativenumber

" activate visual feedback for the following cases
set list
" Reset listchars
set listchars=""
" Show tabs as |---
set listchars+=tab:\|-
" Show trailing spaces as dots
set listchars+=trail:.
" The character to show in the last column when wrap is off and the line
" continues beyond the right of the screen
set listchars+=extends:>
" The character to show in the last column when wrap is off and the line
" continues beyond the right of the screen
set listchars+=precedes:<

set autoindent
syntax on

set background=dark
colorscheme PaperColor

execute pathogen#infect()
filetype plugin indent on

let @i = "oimport ipdb; ipdb.set_trace()"
let @c = "0i# "
