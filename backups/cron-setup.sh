#!/usr/bin/env bash
set -euo pipefail

CRON_TMP="$(mktemp)"
CRON_CMD_WEEKLY="$HOME/dotfiles/backups/backup-configs.sh"
CRON_CMD_MONTHLY="$HOME/dotfiles/backups/backup-home.sh"

CRON_LINE_WEEKLY="0 2 * * 0 $CRON_CMD_WEEKLY"
CRON_LINE_MONTHLY="0 3 1 * * $CRON_CMD_MONTHLY"

# Preserve existing crontab if any
if crontab -l >/dev/null 2>&1; then
  crontab -l > "$CRON_TMP"
else
  : > "$CRON_TMP"
fi

# Remove old lines if present, then re-add cleanly
grep -v -F "$CRON_CMD_WEEKLY" "$CRON_TMP" | grep -v -F "$CRON_CMD_MONTHLY" > "${CRON_TMP}.clean"
cat "${CRON_TMP}.clean" > "$CRON_TMP"

printf '%s\n' "$CRON_LINE_WEEKLY" >> "$CRON_TMP"
printf '%s\n' "$CRON_LINE_MONTHLY" >> "$CRON_TMP"

crontab "$CRON_TMP"

rm -f "$CRON_TMP" "${CRON_TMP}.clean"

echo "Installed cron jobs:"
echo "- Weekly (Sun 02:00): $CRON_CMD_WEEKLY"
echo "- Monthly (1st 03:00): $CRON_CMD_MONTHLY"
