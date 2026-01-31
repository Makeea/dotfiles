#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="$HOME/backups"
STAMP="$(date +%Y%m%d-%H%M%S)"
OUTFILE="$BACKUP_DIR/dotfiles-configs-$STAMP.tar.xz"

mkdir -p "$BACKUP_DIR"

# Local config and dotfiles
INCLUDES=(
  "$HOME/dotfiles"
  "$HOME/.bashrc"
  "$HOME/.bash_profile"
  "$HOME/.profile"
  "$HOME/.bash_aliases"
  "$HOME/.zshrc"
  "$HOME/.zprofile"
  "$HOME/.ssh"
  "$HOME/.gnupg"
  "$HOME/.gitconfig"
  "$HOME/.gitconfig.local"
  "$HOME/.git-credentials"
  "$HOME/.vimrc"
  "$HOME/.vim"
  "$HOME/.tmux.conf"
  "$HOME/.config/Code/User"
  "$HOME/.vscode"
  "$HOME/.config/nvim"
  "$HOME/.config/kitty"
  "$HOME/.config/alacritty"
  "$HOME/.config/pip"
  "$HOME/.config/yarn"
  "$HOME/.npmrc"
  "$HOME/.cargo/config.toml"
  "$HOME/.config/gcloud"
  "$HOME/.aws"
  "$HOME/.azure"
  "$HOME/.kube"
  "$HOME/.config"
)

# Selected system configs
SYSTEM_INCLUDES=(
  "/etc/hosts"
  "/etc/fstab"
  "/etc/wsl.conf"
  "/etc/ssh/ssh_config"
  "/etc/ssh/sshd_config"
)

# Exclusions: caches, temp, and bulky package stores
EXCLUDES=(
  "$HOME/.cache"
  "$HOME/.local/share/Trash"
  "$HOME/.npm/_cacache"
  "$HOME/.cargo/registry"
  "$HOME/.cargo/git"
  "$HOME/.rustup"
  "$HOME/.config/Code/CachedData"
  "$HOME/.config/Code/Cache"
  "$HOME/.config/Code/CachedExtensions"
)

LIST_FILE="$(mktemp)"
EXCLUDE_FILE="$(mktemp)"

for path in "${INCLUDES[@]}"; do
  if [[ -e "$path" ]]; then
    printf '%s\n' "$path" >> "$LIST_FILE"
  fi
done

for path in "${SYSTEM_INCLUDES[@]}"; do
  if [[ -e "$path" ]]; then
    printf '%s\n' "$path" >> "$LIST_FILE"
  fi
done

for path in "${EXCLUDES[@]}"; do
  if [[ -e "$path" ]]; then
    printf '%s\n' "$path" >> "$EXCLUDE_FILE"
  fi
done

if [[ ! -s "$LIST_FILE" ]]; then
  echo "No backup targets found. Nothing to do." >&2
  rm -f "$LIST_FILE" "$EXCLUDE_FILE"
  exit 1
fi

TAR_TMP="$BACKUP_DIR/dotfiles-configs-$STAMP.tar"

tar --exclude-from="$EXCLUDE_FILE" -cf "$TAR_TMP" -T "$LIST_FILE"
xz -9e "$TAR_TMP"

rm -f "$LIST_FILE" "$EXCLUDE_FILE"

echo "Backup created: $OUTFILE"
