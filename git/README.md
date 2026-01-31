# Git Configuration (`git/`)

This folder contains a **public-safe Git configuration** intended to be used with a dotfiles repository.

The configuration is designed to:
- Be safe for a **public repo**
- Work cleanly in **WSL, Linux, and macOS**
- Keep **personal identity private**
- Be easy to install and override per machine

---

## Contents

```text
git/
├── .gitconfig
└── README.md
```

### `.gitconfig`

A shared Git configuration file that provides sane defaults without embedding any personal information.

**Important:**
User identity (`name` and `email`) is intentionally **not included** in this file.

---

## How This Works

Git normally reads configuration from:

```text
~/.gitconfig
```

This setup uses a **symlink** so Git reads the version managed by this repository, and then includes a **private, local override** file for personal identity.

---

## Installation (Recommended)

### 0. Use the installer (optional)

Run the helper script to install the symlink and create your local identity file if missing:

```bash
~/dotfiles/git/install.sh
```

### 1. Symlink the repo-managed config

Since `dotfiles` lives in your home directory, run:

```bash
ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig
```

This makes Git use the config from this repository.

### 2. Create your private identity file

Create a local file that is not tracked by Git:

```bash
nano ~/.gitconfig.local
```

Add your personal identity:

```ini
[user]
	name = Your Name
	email = you@example.com
```

This file is automatically included by `.gitconfig`.

### 3. Protect private data

Ensure the dotfiles repo `.gitignore` contains:

```text
.gitconfig.local
*.local
```

This prevents accidental commits of private information.

---

## Public-Safe Defaults

The shared `.gitconfig` sets:

- `main` as the default branch name
- Rebase-by-default pulls
- Pruned fetches
- Sensible push behavior
- Colorized output
- Improved diff algorithm
- Enabled reuse of recorded conflict resolutions (rerere)

All of these apply without forcing identity or credentials.

---

## Verification

Confirm everything is working:

```bash
git config user.name
git config user.email
git config init.defaultBranch
git config pull.rebase
```

Expected results:

- `user.name` and `user.email` come from `~/.gitconfig.local`
- All other settings come from `git/.gitconfig`
