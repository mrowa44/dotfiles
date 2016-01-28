export EDITOR=vim
export VISUAL=vim
export PATH="$PATH:$HOME/.rvm/bin"

if [[ -a /usr/local/rvm/scripts/rvm ]]; then
  source "/usr/local/rvm/scripts/rvm"
fi

autoload -U colors && colors
export CLICOLOR=1

DIRSTACKSIZE=5
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
setopt extendedglob
unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word always_to_end

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

setopt promptsubst
PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%~%{$reset_color%}$(git_prompt_info) '

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select
zstyle ':completion:*' original true
zstyle ':completion:*' verbose true
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' format '%F{yellow}Completing %d%f'
zstyle ':completion:*' warnings '%F{red}No matches for: %d%f'
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

git_prompt_info() {
  current_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ -n $current_branch ]]; then
    echo "(%{$fg_bold[green]%}$current_branch%{$reset_color%}$(parse_git_dirty))"
  fi
}
parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean"  ]] && echo "+"
}

# Colorize man pages
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

export KEYTIMEOUT=1
bindkey "^B" backward-word
bindkey "^W" forward-word

bindkey "^N" down-history
bindkey "^P" up-history
bindkey '^G' insert-last-word

# bindkey "^U" kill-whole-line
# bindkey "^A" beginning-of-line
# bindkey "^E" end-of-line

alias '..'='cd ..'
alias '...'='cd ../..'
alias mkdir="mkdir -p"
alias cp="cp -vi"
alias mv="mv -vi"
alias rm="rm -v"
alias ls="ls -GF"
alias la="ls -GFA"
alias f='find . -iname'
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
alias gm='git merge'
alias gpl="git pull"
alias gplr="git pull --rebase"
alias gpsh="git push"
alias grb='git rebase'
alias grh='git reset HEAD'
alias gsh='git stash'
alias gst="git status"
alias gcp="git cherry-pick"
alias glg="git log --graph --all --abbrev-commit --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %C(blue)~ %an %Cgreen(%cr) %Creset'"
