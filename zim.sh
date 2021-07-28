# cleanup first
rm -rf ~/.zimrc ~/.zshrc ~/.zim
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
rm -rf ~/.zimrc ~/.zshrc
# install starship
sh -c "$(curl -fsSL https://starship.rs/install.sh)"

# install zsh
stow zim
source ~/.zshrc
zimfw install
zimfw clean
zimfw compile
source ~/.zshrc
