zimfw() { source ~/.zim/zimfw.zsh "${@}" }
fpath=(~/dotfiles/zsh/.zim/modules/utility/functions ${fpath})
autoload -Uz mkcd mkpw
source ~/dotfiles/zsh/.zim/modules/environment/init.zsh
source ~/dotfiles/zsh/.zim/modules/input/init.zsh
source ~/dotfiles/zsh/.zim/modules/utility/init.zsh
source ~/dotfiles/zsh/.zim/modules/zsh-completions/zsh-completions.plugin.zsh
source ~/dotfiles/zsh/.zim/modules/completion/init.zsh
source ~/dotfiles/zsh/.zim/modules/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/dotfiles/zsh/.zim/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh/.zim/modules/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/dotfiles/zsh/.zim/modules/zsh-z/zsh-z.plugin.zsh
