zimfw() { source /Users/kwkarlwang/.config/zsh/.zim/zimfw.zsh "${@}" }
fpath=(/Users/kwkarlwang/dotfiles/zsh/.config/zsh/.zim/modules/utility/functions /Users/kwkarlwang/dotfiles/zsh/.config/zsh/.zim/modules/duration-info/functions ${fpath})
autoload -Uz mkcd mkpw duration-info-precmd duration-info-preexec
source /Users/kwkarlwang/dotfiles/zsh/.config/zsh/.zim/modules/environment/init.zsh
source /Users/kwkarlwang/dotfiles/zsh/.config/zsh/.zim/modules/input/init.zsh
source /Users/kwkarlwang/dotfiles/zsh/.config/zsh/.zim/modules/utility/init.zsh
source /Users/kwkarlwang/dotfiles/zsh/.config/zsh/.zim/modules/duration-info/init.zsh
source /Users/kwkarlwang/dotfiles/zsh/.config/zsh/.zim/modules/asciiship/asciiship.zsh-theme
source /Users/kwkarlwang/dotfiles/zsh/.config/zsh/.zim/modules/zsh-completions/zsh-completions.plugin.zsh
source /Users/kwkarlwang/dotfiles/zsh/.config/zsh/.zim/modules/completion/init.zsh
source /Users/kwkarlwang/dotfiles/zsh/.config/zsh/.zim/modules/zsh-autosuggestions/zsh-autosuggestions.zsh
source /Users/kwkarlwang/dotfiles/zsh/.config/zsh/.zim/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /Users/kwkarlwang/dotfiles/zsh/.config/zsh/.zim/modules/zsh-history-substring-search/zsh-history-substring-search.zsh
