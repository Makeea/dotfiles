# WSL Login Banner (`.wsl-banner.sh`)

A lightweight Bash script that displays useful system information every time you open an **interactive WSL shell**.

Designed to be:
- Fast
- Read-only (no system changes)
- WSL-specific
- Safe to source on shell startup

---

## What It Shows

When executed, the banner displays:

- Current user
- Hostname
- Linux distribution
- Kernel version
- System uptime
- Primary IP address
- Root filesystem disk usage
- Current date/time


---

## Intended Use

This script is meant to run:
- In **WSL only**
- In **interactive shells**
- On **terminal startup**

It is **not** intended for:
- Remote Linux servers
- Non-interactive scripts
- Cron jobs

---

## Installation

### 1. Place the script

Recommended location:

```bash
~/dotfiles/wsl/.wsl-banner.sh
```

### 2. Source it from ~/.bashrc

Add the following to the bottom of `~/.bashrc`:

```bash
if [[ -n "$WSL_DISTRO_NAME" && -f ~/dotfiles/wsl/.wsl-banner.sh ]]; then
  source ~/dotfiles/wsl/.wsl-banner.sh
fi
```
