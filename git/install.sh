#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"
TARGET="$HOME/.gitconfig"
SOURCE="$DOTFILES_DIR/git/.gitconfig"
LOCAL="$HOME/.gitconfig.local"

if [[ ! -f "$SOURCE" ]]; then
  echo "Error: $SOURCE not found. Are you running this from a dotfiles clone in $DOTFILES_DIR?" >&2
  exit 1
fi

# Create or replace the symlink for the shared config
ln -sf "$SOURCE" "$TARGET"

# Ensure a local identity file exists (do not overwrite)
if [[ ! -f "$LOCAL" ]]; then
  cat <<'TEMPLATE' > "$LOCAL"
[user]
	name = Your Name
	email = you@example.com
TEMPLATE
  echo "Created $LOCAL (edit with your personal identity)."
else
  echo "$LOCAL already exists."
fi

echo "Installed: $TARGET -> $SOURCE"
