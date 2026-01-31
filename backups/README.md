# Backups

This folder contains two backup scripts. Both create compressed `.tar.xz` archives in `~/backups/` and include selected system files from `/etc`.
It also includes a cron setup helper for scheduling backups.

## backup-configs.sh

Purpose: backs up configuration and dotfiles that you would want to restore quickly.

Includes:
- Common dotfiles and shells configs
- `~/.config` (for app configs)
- SSH and GPG configs
- Git configuration
- Selected `/etc` files

Skips common caches and temp directories.

Run:

```bash
~/dotfiles/backups/backup-configs.sh
```

## backup-home.sh

Purpose: backs up your entire home directory while skipping common cache/temp directories.

Includes:
- Everything under `~`
- Selected `/etc` files

On start it prompts whether to include `~/backups`. Default is **No** (if you press Enter or wait 10 seconds, it will be excluded).

Run:

```bash
~/dotfiles/backups/backup-home.sh
```

## cron-setup.sh

Purpose: installs cron jobs to run the backups on a schedule.

Defaults:
- Weekly (Sunday at 02:00) runs `backup-configs.sh`
- Monthly (1st at 03:00) runs `backup-home.sh`

Run:

```bash
~/dotfiles/backups/cron-setup.sh
```
