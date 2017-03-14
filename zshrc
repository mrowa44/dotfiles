### General
export EDITOR=vim
export VISUAL=vim
export PGDATA=/usr/local/var/postgres

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

source `brew --prefix`/etc/profile.d/z.sh

### Version managers
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

export NVM_DIR="$HOME/.nvm"
source "/usr/local/opt/nvm/nvm.sh"

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit

### Bindings
bindkey "^B" backward-kill-word
bindkey '^G' insert-last-word
bindkey "^W" foreward-word
bindkey "^V" backward-word
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward

### Custom functions
mkdirc() { mkdir -p "$1" && cd "$1"; }
f() { find . -iname "$1*"; } # f \*.spec -> a/b/abc.spec.js
ff() { find . -iname "*${1:-}*" }
whats_on_port() { lsof -i :$1 }
gJapierdoleCotojestzabrancz() { git log --oneline --color HEAD..$1 }
gJaJebeAlecotojestzabranchseriopytam() { git diff HEAD..$1 }
dockerbash () { docker exec -it $1 bash }

finder() { # cd to top finder window
  finderPath=`osascript -e 'tell application "Finder"
      try
        set currentFolder to (folder of the front window as alias)
      on error
        set currentFolder to (path to desktop folder as alias)
      end try
      POSIX path of currentFolder
    end tell'`;
  cd "$finderPath"
}

man() { # Colorize man pages
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

extract () { # Extract archives
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

yolo() {
  dropdb database_development
  createdb database_development
  sequelize db:migrate
}

### General aliases
alias -g H='| head'
alias -g T='| tail'
alias -g cat="ccat"

alias '..'='cd ..'
alias '...'='cd ../..'
alias mkdir="mkdir -p"
alias cp="cp -vi"
alias mv="mv -vi"
alias ls="ls -GF"
alias la="ls -GFA"
alias rm='rm'
alias ps='ps aux'
alias j='z'
alias cask="brew cask"
alias open_ports='lsof -i -P | ag listen'
alias progress='watch progress -q'
alias serve_this='python -m SimpleHTTPServer'
alias watch_them_styles='sass --watch style.scss:style.css'
alias ip='ipconfig getifaddr en0'
alias tmux='tmux -CC'
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"

### Lang/tool specific aliases
alias -g be='bundle exec'
# alias -g r='rails'

alias nr='npm run'
alias s='npm start'
alias l='./node_modules/eslint/bin/eslint.js .'
alias t='mocha --recursive'
alias d='npm run debug'
alias mochadbg='mocha --debug-brk --inspect --recursive'

alias rios='react-native run-ios --simulator="iPhone 7"'
alias ran='react-native run-android'

alias docker_setup='docker-machine env && eval $(docker-machine env)'

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
alias ga='git add'
alias gaa="git add --all && echo -e '${RED}------> current branch: ${GREEN}${branch}${RED} <------${NC}'"
alias gb="git branch"
alias gc!='git commit -v --amend'
alias gc="git commit -v"
alias gco='git checkout'
alias gcp="git cherry-pick"
alias gd="git diff"
alias gdc='git diff --cached'
alias glg="git log --oneline --graph --color"
alias gm='git merge'
alias gpl="git pull"
alias gpsh="git push"
alias grb='git rebase'
alias gsh='git stash'
alias gst="git status"

alias gdn='git diff --name-only'
alias gplr="git pull --rebase"
alias grh='git reset HEAD'
alias gs="git show"
alias 'gsh popf'='git checkout -- .'
alias gshl='git stash list'
alias gum='git reset --hard ORIG_HEAD'
alias gsup='git submodule update'
alias g_defuq_i_just_did='git diff HEAD~1'
alias gcf='git clean -f'

### Random
export ANDROID_HOME=/usr/local/opt/android-sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools

export PATH="$HOME/.yarn/bin:$PATH"
