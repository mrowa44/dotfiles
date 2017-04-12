### General
export EDITOR=vim
export VISUAL=vim

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

### Aliases
alias -g H='| head'
alias -g T='| tail'
alias -g cat="ccat"
alias ls="ls -GF"
alias '..'='cd ..'
alias '...'='cd ../..'
alias j='z'
alias cask="brew cask"
alias open_ports='lsof -i -P | ag listen'
alias progress='watch progress -q'
alias watch_them_styles='sass --watch style.scss:style.css'
alias ip='ipconfig getifaddr en0'
alias 'tmux ls'='tmux list-sessions'
alias wut='tldr' # too hard to type

alias nr='npm run'
alias s='npm start'
alias t='npm test'
alias d='npm run debug'

### Random
source `brew --prefix`/etc/profile.d/z.sh
export PATH="$HOME/.yarn/bin:$PATH"

### Plugins
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi
source ~/.zplug/init.zsh
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure", use:pure.zsh, as:theme
zplug "zsh-users/zsh-completions"
zplug "mrowa44/vanilla-git-aliases"
zplug "modules/utility", from:prezto
# zplug "modules/node", from:prezto
# zplug "modules/ruby", from:prezto
zplug "lib/history", from:oh-my-zsh
zplug "plugins/osx", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh
 COMPLETION_WAITING_DOTS=true
zplug "zuxfoucault/colored-man-pages_mod"
zplug "zsh-users/zsh-autosuggestions"
zplug "zdharma/fast-syntax-highlighting"
if ! zplug check --verbose; then
  zplug install
fi
zplug load
