setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
setopt HIST_IGNORE_ALL_DUPS

stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
WORDCHARS=${WORDCHARS//[\/]}
# beeping is annoying
unsetopt BEEP


# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
# zmodload zsh/zprof

# compinit
_comp_options+=(globdots)		# Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

# Useful Functions
source "$HOME/zsh/zsh-functions"

# Normal files to source
zsh_add_file "zsh-exports"
zsh_add_file "zsh-vim-mode"
zsh_add_file "zsh-aliases"
eval "$(starship init zsh)"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_plugin "zsh-users/zsh-history-substring-search"
zsh_add_plugin "agkozak/zsh-z"

# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions
ZSH_AUTOSUGGEST_IGNORE_WIDGETS+=(backward-kill-word)
# Key-bindings
bindkey -s '^o' 'ranger^M'
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# FZF 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
compinit
