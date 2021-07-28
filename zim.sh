rm -rf ~/.zimrc ~/.zshrc ~/.zim
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
rm -rf ~/.zimrc ~/.zshrc
stow zim
source ~/.zshrc
zimfw install
zimfw clean
zimfw compile
source ~/.zshrc
