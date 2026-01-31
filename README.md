# dotfiles

Personal dotfiles and helper scripts for a Linux / WSL development environment.

This repo is public-friendly (no personal identity baked in) and is intended for:
- People who want to mirror this setup on their own machine
- Contributors who want to extend the scripts or add new modules

The setup is designed to be:
- Safe to run multiple times
- Portable across WSL, native Linux, and macOS
- Explicit and easy to audit
- Version controlled

---

## What this repo does

At the top level you get:
- A repeatable install flow (`install.sh`)
- An environment check (`bootstrap.sh`)
- A curated Bash aliases file (`bash/aliases.sh`)
- Optional modules for Git config, WSL banner, and backups (see per-folder READMEs)

If you are just here to use it, the install steps below are enough. If you want details or to contribute, each folder has its own README.

---

## Quick start

Clone the repository and run the installer:

```bash
git clone https://github.com/makeea/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

Reload your shell so aliases take effect:

```bash
source ~/.bashrc
```

---

## Install overview

### 1) Get the repo

```bash
git clone https://github.com/makeea/dotfiles.git ~/dotfiles
```

Or download a ZIP and extract to `~/dotfiles`.

### 2) Run the installer

```bash
cd ~/dotfiles
./install.sh
```

What it does:
- Symlinks `bash/aliases.sh` to `~/.bash_aliases`
- Ensures `~/.bashrc` sources `~/.bash_aliases`
- Prints OS/WSL info and exits safely on repeat runs

### 3) Optional components

Each module is documented in its folder:
- `git/README.md` for Git config and `git/install.sh`
- `wsl/readme.md` for the WSL login banner
- `backups/README.md` for backup scripts and cron helper

---

## Root scripts (not in a folder)

### install.sh

Installs the core shell aliases by symlinking:
- `bash/aliases.sh` -> `~/.bash_aliases`

It also appends a small block to `~/.bashrc` if needed so aliases load automatically.

### bootstrap.sh

Detects the current OS and whether the shell is running under WSL. It prints the environment and exits without making changes. Use this to sanity-check detection logic:

```bash
./bootstrap.sh
```

---

## Repository structure

```
dotfiles/
├── bash/
│   └── aliases.sh
├── backups/
│   ├── backup-configs.sh
│   ├── backup-home.sh
│   ├── cron-setup.sh
│   ├── prune.sh
│   ├── restore.md
│   └── README.md
├── git/
│   ├── .gitconfig
│   ├── install.sh
│   └── README.md
├── wsl/
│   ├── readme.md
│   └── wsl-banner.sh
├── bootstrap.sh
├── install.sh
├── README.md
└── LICENSE
```

---

## Contributing

Issues and PRs are welcome. Please keep new scripts small, explicit, and safe to re-run. If you add a new module, include a README in that folder and link it here.
