export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="simple"
DISABLE_AUTO_UPDATE="false"
export UPDATE_ZSH_DAYS=14
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"

source $ZSH/oh-my-zsh.sh
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export EDITOR=vim

# plugins=(git)

alias -g v='vim'
alias -g g='git'
alias -g cat='ccat'
alias -g H='| head'
alias -g T='| tail'
alias fd='find . -type d -name'
alias ff='find . -type f -name'
