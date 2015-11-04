export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="simple"
DISABLE_AUTO_UPDATE="false"
export UPDATE_ZSH_DAYS=14
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"

# plugins=(git)

source $ZSH/oh-my-zsh.sh
export EDITOR=vim
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Vi mode
bindkey -v
export KEYTIMEOUT=1
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# fpath=($HOME/.zsh ${fpath})

# tmuxinator
fpath=($HOME/.tmuxinator/completion ${fpath})
autoload -U compinit
compinit

# . /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

alias -g cat='ccat'
alias -g H='| head'
alias -g T='| tail'
alias fd='find . -type d -iname'
alias ff='find . -type f -iname'
alias -g mutt 'cd ~/Desktop && mutt'

# git because fuck you
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcb='git checkout -b'
alias gcm='git checkout master'
alias gco='git checkout'
alias gd='git diff'
alias gdca='git diff --cached'
alias gf='git fetch'
alias gl='git pull'
alias glg="git log --abbrev-commit --date=relative --graph --pretty=format:'%C(yellow)%h%Creset %s %Cblue~ %cn %Creset(%Cgreen%ar)%Cred%d%Creset'"
alias glo='git log --oneline --decorate --color'
alias glog='git log --oneline --decorate --color --graph'
alias gm='git merge'
alias gmom='git merge origin/master'
alias gp='git push'
alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grbm='git rebase master'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias grv='git remote -v'
alias gst='git status'
alias gsta='git stash'
alias gstaa='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gup='git pull --rebase'
alias gupv='git pull --rebase -v'

