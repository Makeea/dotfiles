##########
# GENERAL
##########
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias home='cd ~'
alias projects='cd ~/projects'

##########
# GIT (CORE)
##########
alias gs='git status -sb'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend --no-edit'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gl='git pull --rebase'
alias gb='git branch'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gd='git diff'
alias gds='git diff --staged'
alias glg='git log --oneline --graph --decorate --all'
alias gcl='git clone'

##########
# SMART GIT HELPERS
##########

# Commit all tracked changes and push
gcp () {
  git commit -am "$1" && git push
}

# Create new branch and switch
gnew () {
  git checkout -b "$1"
}

##########
# GITHUB CLI / SSH
##########
alias ghme='gh auth status'
alias ghclone='gh repo clone'
alias ghrepo='gh repo view'
alias ghopen='gh repo view --web'
alias ghpr='gh pr create'
alias ghprw='gh pr view --web'
alias ghprs='gh pr status'
alias ghiss='gh issue list'
alias gh-test='ssh -T git@github.com'
alias sshl='ssh-add -l'

# Clone repo and cd into it
ghcd () {
  gh repo clone "$1" && cd "$(basename "$1")"
}

##########
# JEKYLL
##########
alias jserve='bundle exec jekyll serve --livereload --force_polling'
alias jbuild='bundle exec jekyll build'
alias jnew='jekyll new . --force'

##########
# WEB SERVERS (SIMPLE)
##########
alias pyserve='python3 -m http.server 8080'
alias pyserve9='python3 -m http.server 9000'
alias nodeserve='npx serve'

##########
# SMART SERVE (AUTO-DETECT)
##########
serve() {
  local mode=""
  local port=""

  if [[ "$1" =~ ^[0-9]+$ ]]; then
    port="$1"
  else
    mode="$1"
    port="$2"
  fi

  [[ -z "$port" ]] && port=8080

  if [[ -z "$mode" ]]; then
    if [[ -f "Gemfile" && -f "_config.yml" ]]; then
      mode="jekyll"
    elif [[ -f "package.json" ]]; then
      mode="js"
    else
      mode="py"
    fi
  fi

  case "$mode" in
    jekyll)
      echo "▶ Serving Jekyll on port $port"
      bundle exec jekyll serve --port "$port" --livereload --force_polling
      ;;
    js)
      echo "▶ Serving Node static site on port $port"
      npx serve -l "$port"
      ;;
    py)
      echo "▶ Serving Python static site on port $port"
      python3 -m http.server "$port"
      ;;
    *)
      echo "❌ Unknown mode: $mode"
      return 1
      ;;
  esac
}

##########
# NODE / NVM
##########
alias nls='nvm ls'
alias nuse='nvm use'
alias ninstall='nvm install'
alias npm-clean='rm -rf node_modules package-lock.json'

##########
# PYTHON
##########
alias venv='python3 -m venv .venv'
alias vact='source .venv/bin/activate'
alias vdeact='deactivate'

##########
# RUBY / RBENV
##########
alias rls='rbenv versions'
alias ruse='rbenv global'
alias rrehash='rbenv rehash'

##########
# SYSTEM / WSL
##########
alias reload='source ~/.bashrc'
alias ports='ss -tulpn'
alias disk='df -h'
alias mem='free -h'

# Full system maintenance (intentional sledgehammer)
alias fullupdate="sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt --fix-broken install -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo apt clean && sudo fstrim /"
