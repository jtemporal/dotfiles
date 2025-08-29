#!/bin/bash
if [ ! -d ~/.vim/autoload ]; then
  mkdir ~/.vim/autoload
fi                                                                              

if [ ! -d ~/.vim/bundle ]; then
  mkdir ~/.vim/bundle
fi                                                                              

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then                                      
  git clone --quiet https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
fi                                                                              

if [ ! -f ~/.vim/autoload/pathogen.vim ]; then
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
  vim +PluginInstall +qall
fi