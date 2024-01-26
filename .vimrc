set cc=80
set ts=4
set sw=4
set sts=4
set scrolloff=8
set sidescrolloff=15
set expandtab
set number

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

" install vundle: copy and paste the lines below in the terminal
"   git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"   vim +PluginInstall +qall

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'NLKNguyen/papercolor-theme'
call vundle#end()

set background=light
colorscheme PaperColor

" install pathogen: copy and paste the lines below in the terminal
"   mkdir -p ~/.vim/autoload ~/.vim/bundle && \
"   curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
"

execute pathogen#infect()
filetype plugin indent on

let @i = "oimport ipdb; ipdb.set_trace()"
let @c = "0wi# "

fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun

command! TW call TrimWhitespace()
