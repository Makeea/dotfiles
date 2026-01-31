#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="$HOME/backups"
KEEP_COUNT=10

prune_type() {
  local pattern="$1"
  local label="$2"

  mapfile -t files < <(ls -1t "$BACKUP_DIR"/$pattern 2>/dev/null || true)
  if (( ${#files[@]} <= KEEP_COUNT )); then
    echo "No pruning needed for $label (count: ${#files[@]})."
    return 0
  fi

  for ((i=KEEP_COUNT; i<${#files[@]}; i++)); do
    rm -f "${files[$i]}"
  done

  echo "Pruned $label backups to last $KEEP_COUNT."
}

prune_type "dotfiles-configs-*.tar.xz" "configs"
prune_type "home-backup-*.tar.xz" "home"
