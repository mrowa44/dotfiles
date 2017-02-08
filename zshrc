export EDITOR=vim
export VISUAL=vim
export PATH="$PATH:$HOME/.rvm/bin"

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"


export NVM_DIR="$HOME/.nvm"
source "/usr/local/opt/nvm/nvm.sh"

export ANDROID_HOME=/usr/local/opt/android-sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools

source `brew --prefix`/etc/profile.d/z.sh

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit

# Colorize man pages
man() {
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

# Extract archives
extract ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
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

bindkey "^B" backward-kill-word
bindkey '^G' insert-last-word
bindkey "^W" foreward-word
bindkey "^V" backward-word

alias '..'='cd ..'
alias '...'='cd ../..'
alias mkdir="mkdir -p"
mkdirc() { mkdir -p "$1" && cd "$1"; }
f() { find . -iname "$1*"; }
gJapierdoleCotojestzabrancz() { git log --oneline --color HEAD..$1 }
gJaJebeAlecotojestzabranchseriopytam() { git diff HEAD..$1 }
dockerbash () { docker exec -it $1 bash }

alias cp="cp -vi"
alias mv="mv -vi"
alias ls="ls -GF"
alias la="ls -GFA"
alias ps='ps aux'
alias todo='$HOME/dotfiles/todoist'
alias j='z'
alias -g H='| head'
alias -g T='| tail'
alias -g cat="ccat"
alias -g be='bundle exec'
# alias -g r='rails'
alias ds='docker-machine env && eval $(docker-machine env)'
alias serve_this='python -m SimpleHTTPServer'
alias watch_them_styles='sass --watch style.scss:style.css'
alias open_ports='lsof -i -P | ag listen'
alias cask="brew cask"
alias vvim="vim -u NONE"
# netstat -nlp tcp | ag 8000
alias rios='react-native run-ios --simulator="iPhone 7"'
alias ran='react-native run-android'
alias progress='watch progress -q'
alias s='npm start'
alias t='npm test'
alias l='./node_modules/eslint/bin/eslint.js .'

# yolo () {
#   j db
#   echo "DROP DATABASE oddshot;" | mysql -h dm -u root
#   ./migrate.sh
#   ./mock_data_sql_scripts/load_mock_data.sh
#   cd -
# }
# kurwa () {
#   docker-machine start
#   j dev
#   ds && docker-compose up -d
#   j web
# }
# rejson() { redis-cli -h dm "$@" | json_pp }
# alias redis-match='redis-cli -h dm --scan --pattern' # pattern: 'escache/dupa*'

alias ga='git add'
alias gaa="git add --all && echo '------> change branch'"
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
