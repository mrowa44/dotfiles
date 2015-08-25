export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="simple"
DISABLE_AUTO_UPDATE="false"
export UPDATE_ZSH_DAYS=14
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"

plugins=(git tmux)

source $ZSH/oh-my-zsh.sh
source /usr/local/bin/tmuxinator.zsh
export EDITOR=vim
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

alias -g v='vim'
alias -g cat='ccat'
alias -g H='| head'
alias -g T='| tail'
alias fd='find . -type d -iname'
alias ff='find . -type f -iname'
