#!/bin/sh
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

if [ ! -f ~/.oh-my-zsh/themes/jesstemporal.zsh-theme ]; then
  curl -sS -o ~/.oh-my-zsh/themes/jesstemporal.zsh-theme https://gist.githubusercontent.com/jtemporal/f0e3e183e0e5b0f1a5473d2448ef4735/raw/jesstemporal.zsh-theme
fi
