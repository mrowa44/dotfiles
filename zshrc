export EDITOR='vim'
export PATH="$PATH:$HOME/.rvm/bin"
export PS1='%B%F{2}%~%b%f%F{6}$(parse_git_branch)%f '
export CLICOLOR='exfxcxdxbxegedabagacad'

if [[ -a /usr/local/rvm/scripts/rvm ]]; then
  source "/usr/local/rvm/scripts/rvm"
fi

setopt prompt_subst
setopt menu_complete
setopt always_to_end
unsetopt complete_in_word

autoload -U compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors $CLICOLOR
zstyle ':completion::complete:*' use-cache 1

# bindkey -v
export KEYTIMEOUT=1
#bindkey '^J' up-history
#bindkey '^K' down-history
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

alias -g ls='ls'
alias -g be='bundle exec'
alias -g H='| head'
alias -g T='| tail'
alias -g ls='ls --color=auto'
alias ff='find . -type f -iname'
alias fd='find . -type d -iname'
alias '..'='cd ..'
alias '...'='cd ../..'

alias -g r='rails'
alias ga='git add'
alias gaa='git add --all'
alias gb="git branch"
alias gc="git commit -v"
alias gc!='git commit -v --amend'
alias gco='git checkout'
alias gd="git diff"
alias gdca='git diff --cached'
alias gdc='git diff --cached'
alias gpl="git pull"
alias gplr="git pull --rebase"
alias gpsh="git push"
alias grb='git rebase'
alias grbm='git rebase master'
alias grh='git reset HEAD'
alias gsh='git stash'
alias gst="git status"
alias gcp="git cherry-pick"
alias glo='git log --oneline --decorate --color'
alias glog='git log --oneline --decorate --color --graph'
alias glg="git log --abbrev-commit --date=relative --graph --pretty=format:'%C(yellow)%h%Creset %s %Cblue~ %cn %Creset(%Cgreen%ar)%Cred%d%Creset'"

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}
