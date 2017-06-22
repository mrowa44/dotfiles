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
alias ll='ls -lh'
alias la='ls -lha'
alias '..'='cd ..'
alias '...'='cd ../..'
alias j='z'
alias cask="brew cask"
alias open_ports='lsof -i -P | ag listen'
whats_on_port() { lsof -i :$1 }
alias progress='watch progress -q'
alias watch_them_styles='sass --watch style.scss:style.css'
alias serve_this='python -m SimpleHTTPServer'
alias static='watch_them_styles & serve_this & open http://localhost:8000'
alias ip='ipconfig getifaddr en0'
alias 'tmux ls'='tmux list-sessions'
alias y='yarn'
alias ys='yarn start'
yt() {
  NODE_ENV=test yarn test
}
yti() {
  NODE_ENV=test mocha --debug-brk --inspect --recursive
}
alias yd='yarn debug'
alias '?'='tldr'
alias seq='sequelize'
alias be='bundle exec'

fix_postgres() {
  rm /usr/local/var/postgres/postmaster.pid
  brew services restart postgresql
}
fix_rubygems() {
  gem update --system
}

### Random
autoload -U promptinit compinit
promptinit; compinit;
prompt pure

setopt MENU_COMPLETE # auto select first autocompl
setopt append_history share_history histignorealldups # shared hist between sessions
unsetopt beep # turn off fucking bell when tabbing
zstyle ':completion:*' menu select # highlight tabbing
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*' # case insensitive compl
zmodload zsh/complist && bindkey -M menuselect '^[[Z' reverse-menu-complete # shift tab to reverse compl selection

export EDITOR=vim
source ~/dotfiles/vanilla-git-aliases/vanilla-git-aliases.zsh
source `brew --prefix`/etc/profile.d/z.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
