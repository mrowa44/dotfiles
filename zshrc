### Bindings
bindkey -e
bindkey "^B" backward-kill-word     # Ctrl+B (delete word backward)
bindkey '^G' insert-last-word       # Ctrl+G (insert last word)
bindkey "^P" up-line-or-history     # Ctrl+P (previous command)
bindkey "^N" down-line-or-history   # Ctrl+N (next command)

bindkey "^[[1;3C" forward-word      # Option+Right arrow (move right by word)
bindkey "^[[1;3D" backward-word     # Option+Left arrow (move left by word)

### ZSH setup
# https://stackoverflow.com/questions/13762280/zsh-compinit-insecure-directories#comment58565664_22753363
fpath+=("/opt/homebrew/share/zsh/site-functions")
autoload -U compinit; compinit;
autoload -U promptinit; promptinit
prompt pure

# Path
PATH="/usr/local/bin:$PATH"
PATH="/opt/homebrew/bin:$PATH"

# Options
setopt MENU_COMPLETE # auto select first autocompl
setopt append_history inc_append_history share_history histignorealldups # shared hist between sessions
unsetopt beep # turn off fucking bell when tabbing

setopt AUTO_CD                    # cd by typing directory name if it's not a command
setopt CORRECT                    # command auto-correction
setopt EXTENDED_GLOB              # extended globbing syntax
setopt HIST_EXPIRE_DUPS_FIRST    # expire duplicate entries first when trimming history
setopt HIST_IGNORE_DUPS          # ignore duplicated commands history list
setopt HIST_IGNORE_SPACE         # ignore commands that start with space
setopt HIST_VERIFY               # show command with history expansion to user before running it
setopt INTERACTIVE_COMMENTS      # allow comments in interactive shell
setopt NO_CASE_GLOB              # case insensitive globbing
setopt NUMERIC_GLOB_SORT         # sort filenames numerically when it makes sense
zstyle ':completion:*' menu select # highlight tabbing
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*' # case insensitive compl
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # colored completions
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
zmodload zsh/complist && bindkey -M menuselect '^[[Z' reverse-menu-complete # shift tab to reverse compl selection

set show-all-if-ambiguous on
set completion-ignore-case on

# Environment
export EDITOR=vim
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color
export PATH="/usr/local/sbin:$PATH"

# History settings
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

# Load external files
source ~/dotfiles/git-aliases.zsh
source ~/dotfiles/helpers.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters
autoload -U add-zsh-hook
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# NVM setup
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm use default

# Zoxide (smart cd)
eval "$(zoxide init zsh)"

[ -f ~/dotfiles/SUPER_SECRETS_DONT_COMMIT_LOL ] && source ~/dotfiles/SUPER_SECRETS_DONT_COMMIT_LOL