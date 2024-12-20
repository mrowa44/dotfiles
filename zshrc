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
alias ls="ls -GF"
alias ll='ls -lh'
alias la='ls -lha'
alias '..'='cd ..'
alias '...'='cd ../..'
alias '....'='cd ../../..'
alias '.....'='cd ../../../..'
alias j='z'
alias f="fd"
alias cask="brew cask"
alias open_ports='lsof -i -P | ag listen'
whats_on_port() { lsof -i :$1 }
whats_on_ports() {
  lsof -iTCP -sTCP:LISTEN -n -P | awk 'NR>1 {print $9, $1, $2}' | sed 's/.*://' | while read port process pid; do echo "Port $port: $(ps -p $pid -o command= | sed 's/^-//') (PID: $pid)"; done | sort -n
}
alias progress='watch progress -q'
alias watch_them_styles='sass --watch style.scss:style.css'
alias serve_this='python3 -m http.server'
# alias serve_this='python -m SimpleHTTPServer'
alias static='watch_them_styles & serve_this & open http://localhost:8000'
alias ip='ipconfig getifaddr en0'
alias 'tmux ls'='tmux list-sessions'
alias y='yarn'
alias ys='yarn start'
alias ysb='yarn storybook'
alias gpshh='git push -u && open $(git remote get-url origin) && a'
alias gpsh='gpsh && a'
alias gpll='git pull && yarn && a'
alias org='open $(git remote get-url origin)'
alias origin='open $(git remote get-url origin)'
alias touhc='touch'
alias eixt="exit"
alias '?'='howdoi'
alias alert="; osascript -e 'display notification \"completed!\" with title \"Done!\" sound name \"Purr\"'"
alias 'a'='alert'
alias -g icloud="/Users/$(whoami)/Library/Mobile\ Documents/com~apple~CloudDocs/"
alias fix="echo 'prettier + eslint + typescript' && yarn format && yarn lint && yarn ts-check && a && gst"
alias 'yarn build'="yarn build && a"
alias mkdir="mkdir -p"
alias 'gpsh'='gpsh && a'
alias 'gc'='gc && gst'
alias nvm-set='node -v > .nvmrc'
alias python='python3'
alias qgst='gst'
alias fix='yarn biome check . --staged --write'

# alias -g cat="bat" // this fixes pure prompt branch
cat() {
  bat $@
}
ydf() {
  yarn dev --filter="$@"...
}
ydff() {
  yarn dev --filter=@layerzerolabs/"$@"...
}
ybf() {
  yarn build --filter="$@"...
}
help() {
  tldr "$@"
  howdoi "$@"
}
copy() { # to clipboard
  pbcopy < $@
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
fix_circle() {
  yarn
  bundle
  rake db:migrate
  gco -- app/*/*.rb db/*.rb
  alert
  foreman start
}
dev() {
  npx turbo run dev --filter=$@
}
build() {
  npx turbo run build --filter=$@...
}

### ZSH setup stuff
# https://stackoverflow.com/questions/13762280/zsh-compinit-insecure-directories#comment58565664_22753363
fpath+=("/opt/homebrew/share/zsh/site-functions")
autoload -U compinit; compinit;
autoload -U promptinit; promptinit
prompt pure

PATH="/usr/local/bin:$PATH"
PATH="/opt/homebrew/bin:$PATH"
# export PATH="node_modules/.bin:/usr/local/lib/node_modules/yarn/bin:$PATH"

setopt MENU_COMPLETE # auto select first autocompl
setopt append_history inc_append_history share_history histignorealldups # shared hist between sessions
unsetopt beep # turn off fucking bell when tabbing
zstyle ':completion:*' menu select # highlight tabbing
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*' # case insensitive compl
zmodload zsh/complist && bindkey -M menuselect '^[[Z' reverse-menu-complete # shift tab to reverse compl selection

set show-all-if-ambiguous on
set completion-ignore-case on

export EDITOR=vim
export LC_ALL=en_US.UTF-8
source ~/dotfiles/vanilla-git-aliases/vanilla-git-aliases.zsh
# source `brew --prefix`/etc/profile.d/z.sh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export PATH="$PATH:$HOME/.rvm/bin"
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters

autoload -U add-zsh-hook
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

nvm use default
export TERM=xterm-256color
export PATH="/usr/local/sbin:$PATH"

# # make all apps in /Applications available from the command line
# # https://hamberg.no/erlend/posts/2014-02-15-make-mac-apps-available-from-cmd-line.html
# for a in {$HOME,}/Applications/*.app(N) ; do
#     eval "\${\${a:t:l:r}//[ -]/}() {\
#         if (( \$# == 0 )); then\
#             open ${(qq)a};\
#         else\
#             open -a ${(qq)a} \$@;\
#         fi\
#     }"
# done

source ~/dotfiles/SUPER_SECRETS_DONT_COMMIT_LOL
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
