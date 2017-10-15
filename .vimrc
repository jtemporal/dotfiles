set cc=80
set ts=4
set sw=4
set sts=4
set scrolloff=8
set sidescrolloff=15
set expandtab
set relativenumber

set autoindent
syntax on

set background=dark
colorscheme PaperColor

execute pathogen#infect()
filetype plugin indent on

let @i = "oimport ipdb; ipdb.set_trace()"
let @c = "0i# "
