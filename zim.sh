# cleanup first
rm -rf ~/.zimrc ~/.zshrc ~/.zim
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
rm -rf ~/.zimrc ~/.zshrc
# install starship
sh -c "$(curl -fsSL https://starship.rs/install.sh)"

# install zsh
stow zim
source ~/.zim/zimfw.zsh install
source ~/.zim/zimfw.zsh clean
source ~/.zim/zimfw.zsh compile
