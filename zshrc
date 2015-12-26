export EDITOR=vim
export VISUAL=vim
export PATH="$PATH:$HOME/.rvm/bin"

if [[ -a /usr/local/rvm/scripts/rvm ]]; then
  source "/usr/local/rvm/scripts/rvm"
fi

setopt promptsubst
PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%~%{$reset_color%}$(git_prompt_info) '

autoload -U colors && colors
export CLICOLOR=1

setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5
setopt extendedglob
unsetopt nomatch

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select=long             # highlight current
zstyle ':completion:*' original true

git_prompt_info() {
  current_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ -n $current_branch ]]; then
    echo "(%{$fg_bold[green]%}$current_branch%{$reset_color%}$(parse_git_dirty))"
  fi
}
parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean"  ]] && echo "*"
}

export KEYTIMEOUT=1
bindkey -v
bindkey '^K' up-history
bindkey '^J' down-history
bindkey "^N" up-history
bindkey "^P" down-history
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^U" kill-line

alias '..'='cd ..'
alias '...'='cd ../..'
alias mkdir="mkdir -p"
alias -g H='| head'
alias -g T='| tail'
alias -g be='bundle exec'
alias -g r='rails'
alias ga='git add'
alias gaa='git add --all'
alias gb="git branch"
alias gc="git commit -v"
alias gc!='git commit -v --amend'
alias gco='git checkout'
alias gd="git diff"
alias gdc='git diff --cached'
alias gpl="git pull"
alias gplr="git pull --rebase"
alias gpsh="git push"
alias grb='git rebase'
alias grh='git reset HEAD'
alias gsh='git stash'
alias gst="git status"
alias gcp="git cherry-pick"
alias glo='git log --oneline --decorate --color --graph'
alias glg="git log --abbrev-commit --date=relative --graph --pretty=format:'%C(yellow)%h%Creset %s %Cblue~ %cn %Creset(%Cgreen%ar)%Cred%d%Creset'"
