# Restore Guide

This guide covers restoring both backups and re-installing the cron schedule.

## Restore configs backup

Example for a configs archive:

```bash
mkdir -p ~/restore
cd ~/restore

# Replace the filename with the archive you want to restore
cp ~/backups/dotfiles-configs-YYYYMMDD-HHMMSS.tar.xz .

# Extract
unxz dotfiles-configs-YYYYMMDD-HHMMSS.tar.xz
tar -xf dotfiles-configs-YYYYMMDD-HHMMSS.tar
```

After extraction, copy or merge files back into your home directory as needed.

## Restore full home backup

Example for a home archive:

```bash
mkdir -p ~/restore
cd ~/restore

# Replace the filename with the archive you want to restore
cp ~/backups/home-backup-YYYYMMDD-HHMMSS.tar.xz .

# Extract
unxz home-backup-YYYYMMDD-HHMMSS.tar.xz
tar -xf home-backup-YYYYMMDD-HHMMSS.tar
```

Carefully review contents before copying files back into `~`.

## Restore cron schedule

Re-install the backup schedule:

```bash
~/dotfiles/backups/cron-setup.sh
```
