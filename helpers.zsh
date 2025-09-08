alias -g H='| head'
alias -g T='| tail'
alias ls="eza"
alias ll='eza -la'
alias la='eza -lha'
alias ~='cd ~'
alias '..'='cd ..'
alias '...'='cd ../..'
alias '....'='cd ../../..'
alias '.....'='cd ../../../..'
alias mkdir="mkdir -p"
alias j='zoxide'
alias f="fd"
alias grep="rg"
alias find="fd"
alias open_ports='lsof -i -P | ag listen'
alias serve_this='python3 -m http.server'
alias ip='ipconfig getifaddr en0'
alias 'tmux ls'='tmux list-sessions'
alias python='python3'
alias alert="; osascript -e 'display notification \"completed!\" with title \"Done!\" sound name \"Purr\"'"
alias 'a'='alert'
alias -g icloud="/Users/$(whoami)/Library/Mobile\ Documents/com~apple~CloudDocs/"
alias path='echo $PATH | tr ":" "\n"'

whats_on_port() { lsof -i :$1 }

whats_on_ports() {
  lsof -iTCP -sTCP:LISTEN -n -P | awk 'NR>1 {print $9, $1, $2}' | sed 's/.*://' | while read port process pid; do echo "Port $port: $(ps -p $pid -o command= | sed 's/^-//') (PID: $pid)"; done | sort -n
}

cat() {
  bat $@
}

copy() { # to clipboard
  pbcopy < $@
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

fix_postgres() {
  rm /usr/local/var/postgres/postmaster.pid
  brew services restart postgresql
}

fix_xcode() { sudo xcode-select -s /Applications/Xcode.app/Contents/Developer }

#################################

dev() {
  npx turbo run dev --filter=$@
}

build() {
  npx turbo run build --filter=$@...
}
