### General
export EDITOR=vim
export VISUAL=vim
export PGDATA=/usr/local/var/postgres

### Bindings
bindkey "^B" backward-kill-word
bindkey '^G' insert-last-word
bindkey "^W" forward-word
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

### Custom functions
f() { find . -iname "$1*"; } # f \*.spec -> a/b/abc.spec.js
ff() { find . -iname "*${1:-}*" }
whats_on_port() { lsof -i :$1 }
fix_postgres() {
  rm /usr/local/var/postgres/postmaster.pid
  brew services restart postgresql
}
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

### Aliases
alias -g H='| head'
alias -g T='| tail'
alias -g cat="ccat"
alias ls="ls -GF"
alias la="ls -GFA"
alias ll='ls -lh'
alias '..'='cd ..'
alias '...'='cd ../..'
alias j='z'
alias cask="brew cask"
alias open_ports='lsof -i -P | ag listen'
alias progress='watch progress -q'
alias serve_this='python -m SimpleHTTPServer'
alias watch_them_styles='sass --watch style.scss:style.css'
alias ip='ipconfig getifaddr en0'
alias 'tmux ls'='tmux list-sessions'

alias nr='npm run'
alias s='npm start'
alias l='./node_modules/eslint/bin/eslint.js .'
alias t='npm test'
alias d='npm run debug'

### Random
source `brew --prefix`/etc/profile.d/z.sh
export PATH="$HOME/.yarn/bin:$PATH"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -Uz compinit
compinit

### Plugins
source ~/.zplug/init.zsh
zplug mafredri/zsh-async
zplug sindresorhus/pure, use:pure.zsh, as:theme
zplug zsh-users/zsh-completions
zplug mrowa44/vanilla-git-aliases
zplug lib/history, from:oh-my-zsh
zplug lib/completion, from:oh-my-zsh
 COMPLETION_WAITING_DOTS=true
zplug modules/utility, from:prezto
zplug modules/node, from:prezto
zplug modules/ruby, from:prezto
zplug zuxfoucault/colored-man-pages_mod
zplug zsh-users/zsh-autosuggestions
zplug zsh-users/zsh-syntax-highlighting, defer:2

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load
