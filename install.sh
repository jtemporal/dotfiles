#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Setting up dotfiles...${NC}"

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to create symlink
create_symlink() {
    local source="$1"
    local target="$2"
    
    if [ -L "$target" ]; then
        echo -e "${YELLOW}⚠️  Removing existing symlink: $target${NC}"
        rm "$target"
    elif [ -f "$target" ]; then
        echo -e "${YELLOW}⚠️  Backing up existing file: $target to $target.backup${NC}"
        mv "$target" "$target.backup"
    fi
    
    echo -e "${GREEN}✅ Creating symlink: $target -> $source${NC}"
    ln -s "$source" "$target"
}

# Create symlinks for dotfiles
echo -e "${GREEN}📁 Creating symlinks for dotfiles...${NC}"
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
create_symlink "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
create_symlink "$DOTFILES_DIR/.bash_profile" "$HOME/.bash_profile"
create_symlink "$DOTFILES_DIR/.bash_aliases" "$HOME/.bash_aliases"
create_symlink "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
create_symlink "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"
create_symlink "$DOTFILES_DIR/.screenrc" "$HOME/.screenrc"
create_symlink "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

# Create .tmuxp directory and symlink
if [ -d "$DOTFILES_DIR/.tmuxp" ]; then
    if [ -L "$HOME/.tmuxp" ]; then
        rm "$HOME/.tmuxp"
    elif [ -d "$HOME/.tmuxp" ]; then
        mv "$HOME/.tmuxp" "$HOME/.tmuxp.backup"
    fi
    echo -e "${GREEN}✅ Creating symlink: $HOME/.tmuxp -> $DOTFILES_DIR/.tmuxp${NC}"
    ln -s "$DOTFILES_DIR/.tmuxp" "$HOME/.tmuxp"
fi

# Create vim directories
echo -e "${GREEN}📦 Setting up Vim...${NC}"
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
  echo -e "${GREEN}📥 Installing Vundle...${NC}"
  git clone --quiet https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  if [ $? -eq 0 ]; then
    echo -e "${GREEN}🔌 Installing Vim plugins...${NC}"
    vim +PluginInstall +qall 2>/dev/null
  fi
fi                                                                              

# Install pathogen
if [ ! -f ~/.vim/autoload/pathogen.vim ]; then
  echo -e "${GREEN}📥 Installing Pathogen...${NC}"
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

# Install custom zsh theme (only if oh-my-zsh exists)
if [ -d ~/.oh-my-zsh ] && [ ! -f ~/.oh-my-zsh/themes/jesstemporal.zsh-theme ]; then
  echo -e "${GREEN}🎨 Installing custom zsh theme...${NC}"
  curl -sS -o ~/.oh-my-zsh/themes/jesstemporal.zsh-theme https://gist.githubusercontent.com/jtemporal/f0e3e183e0e5b0f1a5473d2448ef4735/raw/jesstemporal.zsh-theme
fi

echo -e "${GREEN}🎉 Dotfiles setup complete!${NC}"
echo -e "${YELLOW}💡 You may need to restart your shell or run 'source ~/.zshrc' to see changes.${NC}"
