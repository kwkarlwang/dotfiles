# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}


# --------------------
# Module configuration
# --------------------

#
# zsh-autosuggestions
#

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'
KEYTIMEOUT=1
# ------------------
# Initialize modules
# ------------------
ZIM_HOME=${HOME}/.zim
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Update static initialization script if it does not exist or it's outdated, before sourcing it
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
# eval "$(thefuck --alias)"

# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Bind up and down keys
zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
  bindkey ${terminfo[kcuu1]} history-substring-search-up
  bindkey ${terminfo[kcud1]} history-substring-search-down
fi

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# }}} End configuration added by Zim install

# use vim
bindkey -v
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f "/Users/kwkarlwang/.ghcup/env" ] && source "/Users/kwkarlwang/.ghcup/env" # ghcup-env

bindkey -v '^?' backward-delete-char
bindkey -v '^W' backward-kill-word



# This disable the vim too many open files error
# ulimit -S -n 200048

# This automatically set window name
# function set-title-precmd() {
#   printf "\e]2;%s\a" "${PWD/#$HOME/~}"
# }

# function set-title-preexec() {
#   printf "\e]2;%s\a" "$1"
# }

autoload -Uz add-zsh-hook
# add-zsh-hook precmd set-title-precmd
# add-zsh-hook preexec set-title-preexec

function cpp {
  g++ -std=c++20 -fsanitize=undefined $1 && ./a.out || true
  rm a.out
}

function cpf {
  fd $1 | fzf --height=30% --reverse --info=inline | tee /dev/tty | pbcopy
}

function bazeli {
  capture=$(bazel query $2 | grep "^//" | fzf --height=30% --reverse --info=inline)
  cmd="bazel $1 $capture"
  print -z $cmd
}

function bazel-refresh {
    (bazel query //... | grep "^//") >! $HOME/.bazel_targets
}

_fzf_complete_bazel() {
  _fzf_complete -- "$@" < <(
    cat $HOME/.bazel_targets
  )
}

_fzf_complete_br() {
  _fzf_complete -- "$@" < <(
    cat $HOME/.bazel_targets
  )
}

_fzf_complete_bb() {
  _fzf_complete -- "$@" < <(
    cat $HOME/.bazel_targets
  )
}

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'

function b64json {
  echo $1 | base64 --decode | jq .
}

# ------------------------------
# Alias
# ------------------------------


alias szsh="source $HOME/.zshrc"

alias vim="nvim"

alias mas="cd ~/Desktop/Master/"
alias karl="cd ~/Desktop/Karl/"
alias k="kubectl"
if [ "$TERM" = "xterm-kitty" ]; then
  alias ssh="kitty +kitten ssh"
fi
alias icat="kitty +kitten icat"
alias dot="cd ~/dotfiles"
alias lc="cd ~/leetcode"
alias lg="lazygit"
# use exa if available
if (( $+commands[exa])); then
  alias ls='exa -1 --icons'
  alias lsa='exa -1a --icons'
  alias l='exa -lb --icons'
  alias la='exa -lba --icons'
  alias lt='exa --icons --tree --level=2'
  alias lta='exa -a --icons --tree --level=2'
else
  case "$(uname -s)" in

     Darwin)
       # echo 'Mac OS X'
      alias ls='ls -1 -G'
      alias lsa='ls -1a -G'
      alias l='ls -lb -G'
      alias la='ls -lba -G'
      alias lt='tree -L 2'
      alias lta='tree -La 2'
       ;;

     Linux)
      alias ls='ls -1 --color=auto'
      alias lsa='ls -1a --color=auto'
      alias l='ls -lb --color=auto'
      alias la='ls -lba --color=auto'
      alias lt='tree -L 2'
      alias lta='tree -La 2'
       ;;

     CYGWIN*|MINGW32*|MSYS*|MINGW*)
       # echo 'MS Windows'
       ;;
     *)
       # echo 'Other OS' 
       ;;
  esac
fi
# ------------------------------
# Keybindings
# ------------------------------
bindkey -s '^o' 'ranger^M'
bindkey "\e[1;3D" backward-word # ⌥←
bindkey "\e[1;3C" forward-word # ⌥→
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
# ------------------------------
# Export
# ------------------------------
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"
# For HomeBrew
export PATH="/usr/local/sbin:$PATH"
if [[ $(uname -p) == 'arm' ]]; then
  export PATH="/opt/anaconda3/bin:$PATH"
else
  export PATH="$HOME/anaconda3/bin:$PATH"
fi
# go path
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export VISUAL="nvim"
export EDITOR="nvim"
if [ -f "$HOME/.zshrc.other" ]; then
  source $HOME/.zshrc.other
fi

# Add JBang to environment
alias j!=jbang
export PATH="$HOME/.jbang/bin:$PATH"

[ -f "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Comment out the following as it slows down the startup signficiantly
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/opt/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/opt/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<
