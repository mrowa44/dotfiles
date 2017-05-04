### Bindings
bindkey "^B" backward-kill-word
bindkey '^G' insert-last-word
bindkey "^W" forward-word
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

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
whats_on_port() { lsof -i :$1 }
alias progress='watch progress -q'
alias watch_them_styles='sass --watch style.scss:style.css'
alias ip='ipconfig getifaddr en0'
alias 'tmux ls'='tmux list-sessions'
alias y='yarn'
alias ys='yarn start'
alias yt='NODE_ENV=test yarn test'
alias yti='NODE_ENV=test mocha --debug-brk --inspect --recursive'
alias yd='yarn debug'
alias '?'='tldr'
alias rm='rm'
alias gpshh='git push origin master && git push heroku master'

fix_postgres() {
  rm /usr/local/var/postgres/postmaster.pid
  brew services restart postgresql
}

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

### Random
source `brew --prefix`/etc/profile.d/z.sh
export EDITOR=vim
export PATH="$HOME/.yarn/bin:$PATH"

