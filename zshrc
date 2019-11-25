### Bindings
bindkey -e
bindkey "^B" backward-kill-word
bindkey '^G' insert-last-word
bindkey "^W" forward-word
bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history

### Aliases
alias -g H='| head'
alias -g T='| tail'
alias -g cat="bat"
alias ls="ls -GF"
alias ll='ls -lh'
alias la='ls -lha'
alias '..'='cd ..'
alias '...'='cd ../..'
alias j='z'
alias f="fd"
alias cask="brew cask"
alias open_ports='lsof -i -P | ag listen'
whats_on_port() { lsof -i :$1 }
alias progress='watch progress -q'
alias watch_them_styles='sass --watch style.scss:style.css'
# alias serve_this='python -m http.server'
alias serve_this='python -m SimpleHTTPServer'
alias static='watch_them_styles & serve_this & open http://localhost:8000'
alias ip='ipconfig getifaddr en0'
alias 'tmux ls'='tmux list-sessions'
alias y='yarn'
alias ys='yarn start'
alias yw='yarn watch'
alias yt='NODE_ENV=test yarn test'
alias yti='NODE_ENV=test mocha --inspect-brk --recursive'
alias ytd='node --inspect-brk ./node_modules/netguru-react-scripts/bin/react-scripts.js test --env=jsdom'
alias sl='yarn stylelint'
alias el='eslint'
alias gpshh='git push -u && open $(git remote get-url origin)'
alias org='open $(git remote get-url origin)'
alias origin='open $(git remote get-url origin)'
alias touhc='touch' # please
alias '?'='howdoi'
alias md='open -a MacDown'
alias alert="; osascript -e 'display notification \"completed!\" with title \"Done!\" sound name \"Purr\"'"
alias -g icloud="/Users/$(whoami)/Library/Mobile\ Documents/com~apple~CloudDocs/"
alias flowwatch="fswatch -o ./ | xargs -n1 -I{} sh -c 'clear; printf \"\033[3J\" && ./node_modules/flow-bin/cli.js'"
alias lint_changed="gd --name-only develop | ag js | xargs ../gabi-react/node_modules/eslint/bin/eslint.js"
alias circle_local="circleci local execute --job build"
alias icons='open src/gabi-assets/images/icons'
alias loki_changed='git ls-files -m --others --exclude-standard .loki | xargs open'

help() {
  tldr "$@"
  howdoi "$@"
}
comp() {
  touch src/components/"$@".{js,test.js,scss}
}
view() {
  touch src/views/"$@".{js,test.js,scss}
}
tx() { # attach to a session with name of current directory or create one
  dir=${PWD##*/}
  tmux -CC a -t ${dir} || tmux -CC new -s ${dir}
}
copy() { # to clipboard
  pbcopy < $@
}
youtube_mp3() {
  youtube-dl --extract-audio -i --audio-format mp3 "$@"
}
kill_them_all() {
  ps aux | ag "$@" | awk '{print $2}' | xargs kill
}
burn_them_all() {
  ps aux | ag "$@" | awk '{print $2}' | xargs kill -9
}
man() { # colorful man pages
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    PAGER="${commands[less]:-$PAGER}" \
    _NROFF_U=1 \
    PATH="$HOME/bin:$PATH" \
    man "$@"
}
pg() {
  process_list="$(ps ax -o pid,ppid,user,pcpu,pmem,rss,cputime,state,comm)"
  head -n1 <(echo $process_list)
  command grep -i --color "$1" <(echo $process_list)
}
rm_deep_node_modules() {
  find . -type d -name '*node_modules*' -maxdepth 2
  echo
  echo 'Are you sure you want to remote those directories?'
  read -n 1 REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]] then
    echo 'Ok, removing'
    find . -type d -name '*node_modules*' -maxdepth 2 | xargs rm -rf
  fi
}
fix_postgres() {
  rm /usr/local/var/postgres/postmaster.pid
  brew services restart postgresql
}
fix_rubygems() { gem update --system }
# set right path
fix_xcode() { sudo xcode-select -s /Applications/Xcode.app/Contents/Developer }

### ZSH setup stuff
autoload -U promptinit compinit
promptinit; compinit;
prompt pure

PATH="$PATH:/usr/local/Cellar/ruby/2.5.1/bin"
PATH="/usr/local/bin:$PATH"

setopt MENU_COMPLETE # auto select first autocompl
setopt append_history inc_append_history share_history histignorealldups # shared hist between sessions
unsetopt beep # turn off fucking bell when tabbing
zstyle ':completion:*' menu select # highlight tabbing
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*' # case insensitive compl
zmodload zsh/complist && bindkey -M menuselect '^[[Z' reverse-menu-complete # shift tab to reverse compl selection

set show-all-if-ambiguous on
set completion-ignore-case on

export EDITOR=vim
# export NVM_LAZY_LOAD=true && source ~/dotfiles/zsh-nvm/zsh-nvm.plugin.zsh
source ~/dotfiles/vanilla-git-aliases/vanilla-git-aliases.zsh
source `brew --prefix`/etc/profile.d/z.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

jj() { # "jump" to directory of a project and start tmux session
  j "$@"
  tx
}

 export NVM_DIR="$HOME/.nvm"
 [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
 [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

autoload -U add-zsh-hook

eval $(thefuck --alias)

nvm use default
export TERM=xterm-256color
export PATH="/usr/local/sbin:$PATH"

# make all apps in /Applications available from the command line
# https://hamberg.no/erlend/posts/2014-02-15-make-mac-apps-available-from-cmd-line.html
for a in {$HOME,}/Applications/*.app(N) ; do
    eval "\${\${a:t:l:r}//[ -]/}() {\
        if (( \$# == 0 )); then\
            open ${(qq)a};\
        else\
            open -a ${(qq)a} \$@;\
        fi\
    }"
done
