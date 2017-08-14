#!/bin/sh

# homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade --all
brew doctor
brew -v

# brew list
brew install mas
brew install homebrew/php/composer
brew install mysql
brew install openssl
brew install wget
brew install gettext
brew install curl
brew install tig
brew install git
Brew install git-ftp

# terminal
brew install zsh
brew install tmux
brew install vim
brew install reattach-to-user-namespace

zsh

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

mkdir zsh_orig && mv zshmv .zlogin .zlogout .zprofile .zshenv .zshrc zsh_orig

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

echo /usr/local/bin/zsh >> /etc/shells

chsh -s /usr/local/bin/zsh

ln -sf ~/osx-setup/.zshrc ~/.zshrc

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf ~/osx-setup/.tmux.conf ~/.tmux.conf

# vim
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
git clone https://github.com/altercation/vim-colors-solarized.git ~/vim-colors-solarized
mv ~/vim-colors-solarized/colors ~/.vim/
ln -sf ~/osx-setup/.vimrc ~/.vimrc
rm -rf ~/vim-colors-solarized

# solarized color
git clone https://github.com/tomislav/osx-terminal.app-colors-solarized solarized.git

# Apps
brew cask install google-chrome
brew cask install bettertouchtool
brew cask install slack
brew cask install docker-toolbox
brew cask install dropbox
brew cask install 1password
brew cask install tower
brew cask install phpstorm
brew cask install virtualbox
brew cask install skype
brew cask install sequel-pro
brew cask install macdown
brew cask install appcleaner
brew cask install clipy
brew cask install coteditor
brew cask install amazon-drive
brew cask install cmd-eikana

mas install 497799835 # xcode
