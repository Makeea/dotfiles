##########
# GENERAL
##########
alias ll='ls -alF'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias home='cd ~'
alias projects='cd ~/projects'

##########
# GIT
##########
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline --graph --decorate'
alias gb='git branch'
alias gco='git checkout'
alias gcl='git clone'

##########
# GITHUB / SSH
##########
alias gh-test='ssh -T git@github.com'
alias sshl='ssh-add -l'

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
# WSL / SYSTEM
##########
alias reload='source ~/.bashrc'
alias ports='ss -tulpn'
alias disk='df -h'
alias mem='free -h'

##########
# SMART SERVE (AUTO-DETECT PROJECT TYPE)
##########

serve() {
  local mode=""
  local port=""

  # Parse arguments
  if [[ "$1" =~ ^[0-9]+$ ]]; then
    port="$1"
  else
    mode="$1"
    port="$2"
  fi

  # Default port
  [[ -z "$port" ]] && port=8080

  # Auto-detect project type
  if [[ -z "$mode" ]]; then
    if [[ -f "Gemfile" && -f "_config.yml" ]]; then
      mode="jekyll"
    elif [[ -f "package.json" ]]; then
      mode="js"
    elif [[ -f "index.html" ]]; then
      mode="py"
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
      echo "Usage:"
      echo "  serve"
      echo "  serve 4000"
      echo "  serve jekyll 4000"
      echo "  serve js 9000"
      echo "  serve py 8000"
      return 1
      ;;
  esac
}
