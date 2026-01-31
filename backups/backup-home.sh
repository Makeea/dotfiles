#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="$HOME/backups"
STAMP="$(date +%Y%m%d-%H%M%S)"
OUTFILE="$BACKUP_DIR/home-backup-$STAMP.tar.xz"

mkdir -p "$BACKUP_DIR"

# Prompt for including ~/backups (default: exclude) with countdown
INCLUDE_BACKUPS="no"
REPLY=""
for i in {10..1}; do
  echo -ne "Include ~/backups in the archive? (y/N) ${i}s \r"
  if read -r -t 1 -n 1 key; then
    REPLY="$key"
    echo
    break
  fi
done
if [[ -z "$REPLY" ]]; then
  echo
fi
case "${REPLY:-}" in
  y|Y)
    INCLUDE_BACKUPS="yes"
    ;;
esac

# Full home directory
INCLUDES=(
  "$HOME"
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

if [[ "$INCLUDE_BACKUPS" != "yes" ]]; then
  EXCLUDES+=("$HOME/backups")
fi

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

TAR_TMP="$BACKUP_DIR/home-backup-$STAMP.tar"

tar --exclude-from="$EXCLUDE_FILE" -cf "$TAR_TMP" -T "$LIST_FILE"
xz -9e "$TAR_TMP"

rm -f "$LIST_FILE" "$EXCLUDE_FILE"

echo "Backup created: $OUTFILE"
