#!/usr/bin/env bash
set -e

echo "Installing dotfiles environment"

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup"

OS="$(uname -s)"
IS_WSL=false

if [ -r /proc/version ] && grep -qi microsoft /proc/version; then
  IS_WSL=true
fi

echo "Dotfiles directory: $DOTFILES_DIR"
echo "Operating system: $OS"
echo "WSL detected: $IS_WSL"
echo ""

############################
# Backup helper
############################
backup_file() {
  local target="$1"

  if [ -e "$target" ] && [ ! -L "$target" ]; then
    mkdir -p "$BACKUP_DIR"
    mv "$target" "$BACKUP_DIR/"
    echo "Backed up $target to $BACKUP_DIR"
  fi
}

############################
# Symlink helper
############################
link_file() {
  local src="$1"
  local dest="$2"

  backup_file "$dest"

  if [ -L "$dest" ]; then
    echo "Symlink already exists: $dest"
  else
    ln -s "$src" "$dest"
    echo "Linked $dest -> $src"
  fi
}

############################
# Install aliases
############################
echo "Setting up bash aliases"

link_file "$DOTFILES_DIR/bash/aliases.sh" "$HOME/.bash_aliases"

############################
# Ensure .bashrc loads aliases
############################
BASHRC="$HOME/.bashrc"
ALIAS_BLOCK='
# Load dotfiles aliases
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi
'

if ! grep -q "Load dotfiles aliases" "$BASHRC"; then
  echo "Updating .bashrc to load aliases"
  echo "$ALIAS_BLOCK" >> "$BASHRC"
else
  echo ".bashrc already configured"
fi

############################
# Finish
############################
echo ""
echo "Dotfiles installation complete."
echo "Restart your shell or run: source ~/.bashrc"
