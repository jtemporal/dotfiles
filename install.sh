#!/bin/bash

set -e  # Exit on any error

echo "🚀 Setting up dotfiles..."

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to create symlink safely
link_file() {
    local src="$1"
    local dest="$2"
    
    # Skip if source doesn't exist
    if [ ! -e "$src" ]; then
        echo "⚠️  Skipping $src (doesn't exist)"
        return
    fi
    
    # Backup existing file/symlink
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "📦 Backing up existing $dest"
        mv "$dest" "$dest.backup.$(date +%Y%m%d_%H%M%S)" 2>/dev/null || true
    fi
    
    # Create symlink
    echo "🔗 Linking $dest -> $src"
    ln -sf "$src" "$dest"
}

# Handle .tmuxp directory
if [ -d "$DOTFILES_DIR/.tmuxp" ]; then
    link_file "$DOTFILES_DIR/.tmuxp" "$HOME/.tmuxp"
fi

# Download custom zsh theme (simple, non-blocking)
if [ -d ~/.oh-my-zsh/themes ]; then
    echo "🎨 Installing custom zsh theme..."
    curl -fsSL -o ~/.oh-my-zsh/themes/jesstemporal.zsh-theme \
        https://gist.githubusercontent.com/jtemporal/f0e3e183e0e5b0f1a5473d2448ef4735/raw/jesstemporal.zsh-theme \
        2>/dev/null || echo "⚠️  Failed to download custom theme (continuing anyway)"
fi

# Set up Vim plugins (non-interactive)
echo "📦 Setting up Vim..."
mkdir -p ~/.vim/{autoload,bundle}

# Install Vundle if not present
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    echo "📥 Installing Vundle..."
    git clone --quiet https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 2>/dev/null || {
        echo "⚠️  Failed to install Vundle (continuing anyway)"
    }
fi

# Install Pathogen if not present
if [ ! -f ~/.vim/autoload/pathogen.vim ]; then
    echo "📥 Installing Pathogen..."
    curl -fsSL -o ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim 2>/dev/null || {
        echo "⚠️  Failed to install Pathogen (continuing anyway)"
    }
fi

# Install PaperColor theme directly (avoiding interactive vim)
if [ ! -d ~/.vim/bundle/papercolor-theme ]; then
    echo "🎨 Installing PaperColor theme..."
    git clone --quiet https://github.com/NLKNguyen/papercolor-theme.git ~/.vim/bundle/papercolor-theme 2>/dev/null && {
        echo "✅ PaperColor theme installed"
    } || {
        echo "⚠️  Could not install PaperColor theme"
    }
fi

echo "💡 Note: Vim plugins are installed. You can run ':PluginInstall' in vim later if needed."

# Now handle shell configuration files (these might trigger shell reloads)
echo "📁 Creating symlinks for dotfiles..."
link_file "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
link_file "$DOTFILES_DIR/.bash_profile" "$HOME/.bash_profile"
link_file "$DOTFILES_DIR/.bash_aliases" "$HOME/.bash_aliases"
link_file "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
# link_file "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"
link_file "$DOTFILES_DIR/.screenrc" "$HOME/.screenrc"
link_file "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

# Do zsh config last to minimize reloads
echo "� Setting up zsh configuration..."
link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

echo "✅ Dotfiles setup complete!"
echo "💡 Configuration applied. Shell may reload automatically or restart your terminal."
