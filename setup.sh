#!/bin/sh

# Create vim directories
if [ ! -d ~/.vim ]; then
  mkdir -p ~/.vim
fi

if [ ! -d ~/.vim/autoload ]; then
  mkdir -p ~/.vim/autoload
fi                                                                              

if [ ! -d ~/.vim/bundle ]; then
  mkdir -p ~/.vim/bundle
fi                                                                              

# Install Vundle
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then                                      
  git clone --quiet https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  if [ $? -eq 0 ]; then
    vim +PluginInstall +qall
  fi
fi                                                                              

# Install pathogen
if [ ! -f ~/.vim/autoload/pathogen.vim ]; then
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
  if [ $? -eq 0 ]; then
    vim +PluginInstall +qall
  fi
fi

# Install custom zsh theme (only if oh-my-zsh exists)
if [ -d ~/.oh-my-zsh ] && [ ! -f ~/.oh-my-zsh/themes/jesstemporal.zsh-theme ]; then
  curl -sS -o ~/.oh-my-zsh/themes/jesstemporal.zsh-theme https://gist.githubusercontent.com/jtemporal/f0e3e183e0e5b0f1a5473d2448ef4735/raw/jesstemporal.zsh-theme
fi
