#!/bin/bash

set -ex

sudo -v

# NETWORK TOOLS
sudo pacman -S gnome-keyring networkmanager-openvpn networkmanager-pptp wpa_supplicant

# WEB & MAILS
sudo pacman -S firefox flashplugin

# PHOTO
sudo pacman -S shotwell

# GIT
rm ~/.gitconfig
ln -s ~/dotfiles/git/git.conf ~/.gitconfig

# Terminator
sudo pacman -S terminator
mkdir -p ~/.config/terminator/
if [ ! -e $HOME/.config/terminator/config ]; then
    ln -s ~/dotfiles/terminator/terminator.conf ~/.config/terminator/config
fi
if [ ! -e /etc/xdg/autostart/terminator.desktop ]; then
    sudo ln -s ~/dotfiles/terminator/terminator.desktop /etc/xdg/autostart/terminator.desktop
fi

# SUBLIME TEXT
curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg
echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/dev/x86_64" | sudo tee -a /etc/pacman.conf
sudo pacman -Syu sublime-text
mkdir -p ~/.config/sublime-text-3/Installed\ Packages
mkdir -p ~/.config/sublime-text-3/Packages
curl -L -O https://sublime.wbond.net/Package%20Control.sublime-package
mv Package%20Control.sublime-package ~/.config/sublime-text-3/Installed\ Packages/Package\ Control.sublime-package

if [ ! -d ~/.config/sublime-text-3/Packages/User ]; then
    ln -s ~/dotfiles/sublime ~/.config/sublime-text-3/Packages/User
fi

# DOCKER
sudo pacman -S docker docker-compose
sudo systemctl enable docker
sudo systemctl start docker
sudo gpasswd -a $USER docker

# PHP
sudo pacman -S php php-intl
sudo rm /etc/php/php.ini
if [ ! -e /etc/php/php.ini ]; then
    sudo ln -s ~/dotfiles/php/php.ini /etc/php/php.ini
fi

# PHP TOOLS
if [ ! -e /usr/local/bin/composer ]; then
    curl -O http://getcomposer.org/composer.phar
    sudo mv composer.phar /usr/local/bin/composer
fi
sudo chmod a+x /usr/local/bin/composer
composer global require "squizlabs/php_codesniffer=~3.1"
composer global require "phpmd/phpmd=~2.6"
composer global require "phpunit/phpunit=~6.4"

# Z
if [ ! -d ~/.rupaz ]; then
    git clone git@github.com:rupa/z.git ~/.rupaz
fi

# ZSH
if [ ! -d ~/.oh-my-zsh ]; then
	git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi
if [ ! -e $HOME/.zshrc ]; then
    ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
fi
if [ ! -e $HOME/.oh-my-zsh/themes/owlycode.zsh-theme ]; then
	ln -s ~/dotfiles/zsh/owlycode.zsh-theme ~/.oh-my-zsh/themes/owlycode.zsh-theme
fi
sudo pacman -S zsh zsh-completions
chsh -s /bin/zsh
