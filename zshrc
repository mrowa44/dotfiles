export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="simple"
DISABLE_AUTO_UPDATE="false"
export UPDATE_ZSH_DAYS=14
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"

plugins=(git)

source $ZSH/oh-my-zsh.sh
export EDITOR=vim
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

fpath=($HOME/.zsh ${fpath})

# tmuxinator
fpath=($HOME/.tmuxinator/completion ${fpath})
autoload -U compinit
compinit

alias -g v='vim'
alias -g cat='ccat'
alias -g H='| head'
alias -g T='| tail'
alias fd='find . -type d -iname'
alias ff='find . -type f -iname'

alias glg="git log --abbrev-commit --date=relative --graph --pretty=format:'%C(yellow)%h%Creset %s %Cblue~ %cn %Creset(%Cgreen%ar)%Cred%d%Creset'"
