# dotfiles

Personal dotfiles for a Linux / WSL development environment.

This repository contains shell configuration and aliases used to set up a consistent, repeatable development workflow across machines.

The setup is designed to be:
- Safe to run multiple times
- Portable across WSL, native Linux, and macOS
- Explicit and easy to audit
- Version controlled

---

## Quick start

Clone the repository and run the installer:

```bash
git clone https://github.com/makeea/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

Restart your shell or reload the configuration:

```bash
source ~/.bashrc
```
After this, all aliases and functions provided by the dotfiles
will be available in the shell.
## Repository structure

```
dotfiles/
├── bash/
│   └── aliases.sh
├── git/
│   ├── .gitconfig
│   ├── install.sh
│   └── README.md
├── bootstrap.sh
├── README.md
├── wsl/
│   ├── readme.md
│   └── wsl-banner.sh
└── LICENSE
```

---

## Contents

### bash/aliases.sh

Contains all shell aliases and functions, including:
- Navigation shortcuts
- Git and GitHub helpers
- Jekyll commands
- Python and Node static web servers
- A smart `serve` function that auto-detects project type

This file is intended to be symlinked to `~/.bash_aliases`.

### bootstrap.sh

A safe bootstrap script that:
- Detects operating system (Linux vs macOS)
- Detects WSL vs native Linux
- Prints environment information

Currently, the script performs detection only and makes no system changes. It is intended to be extended over time.

### git/

Public-safe Git configuration plus an installer script:
- `git/README.md` documents the setup
- `git/install.sh` symlinks `~/.gitconfig` and creates `~/.gitconfig.local` if missing

### wsl/

WSL login banner script and documentation:
- `wsl/wsl-banner.sh` prints system info on interactive WSL shells
- `wsl/readme.md` explains installation and intended usage

---

## Installation

### Option 1: Clone with Git (recommended)

```bash
git clone https://github.com/makeea/dotfiles.git ~/dotfiles
```

### Option 2: Download ZIP

- Click **Code → Download ZIP** on GitHub
- Extract the folder to `~/dotfiles`

---

## Setup

### Create the aliases symlink

```bash
ln -s ~/dotfiles/bash/aliases.sh ~/.bash_aliases
```

### Optional: Install Git config

```bash
~/dotfiles/git/install.sh
```

### Optional: Enable WSL login banner

Add this to the bottom of `~/.bashrc` in WSL:

```bash
if [[ -n "$WSL_DISTRO_NAME" && -f ~/dotfiles/wsl/wsl-banner.sh ]]; then
  source ~/dotfiles/wsl/wsl-banner.sh
fi
```



### Ensure `.bashrc` loads aliases (Ubuntu default)

Add the following to `~/.bashrc` if it is not already present:

```bash
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi
```

Reload the shell:

```bash
source ~/.bashrc
```

---

## Bootstrap

Run the bootstrap script to verify OS and environment detection:

```bash
cd ~/dotfiles
chmod +x bootstrap.sh
./bootstrap.sh
```

Example output on WSL:

```
Operating system: Linux
WSL detected: true
Environment: Linux (WSL)
```

Example output on native Linux:

```
Operating system: Linux
WSL detected: false
Environment: Linux (native)
```
