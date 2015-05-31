#!/bin/bash

sudo -v

# MATE APPEARANCE
dconf write /org/mate/marco/general/compositing-manager true
dconf write /org/mate/marco/general/center-new-window true

# GIT
rm ~/.gitconfig
ln -s ~/dotfiles/git.conf ~/.gitconfig

# Terminator
sudo pacman -S terminator
mkdir -p ~/.config/terminator/
ln -s ~/dotfiles/terminator/terminator.conf ~/.config/terminator/config
ln -s ~/dotfiles/terminator/terminator.desktop /etc/xdg/autostart/terminator.desktop

# SUBLIME TEXT (editor, keymap, config, packages)
sudo pacman -S gtk2 libpng
mkdir -p ~/builds
cd ~/builds
curl -L -O https://aur.archlinux.org/packages/su/sublime-text-dev/sublime-text-dev.tar.gz
tar -xvf sublime-text-dev.tar.gz
cd sublime-text-dev
nano PKGBUILD
nano sublime-text-dev.install
makepkg -si

# DOCKER
sudo pacman -S docker
sudo systemctl enable docker
sudo systemctl start docker
sudo gpasswd -a $USER docker

# PHP
sudo pacman -S php php-intl
sudo rm /etc/php/php.ini
sudo ln -s ~/dotfiles/php/php.ini /etc/php/php.ini

# PHP TOOLS
curl -O http://getcomposer.org/composer.phar
sudo mv composer.phar /usr/local/bin/composer
sudo chmod a+x /usr/local/bin/composer
composer global require "squizlabs/php_codesniffer=~2.3"
composer global require "phpmd/phpmd=~2.2"
composer global require "phpunit/phpunit=~4.6"

# Z
git clone git@github.com:rupa/z.git ~/.rupaz

# ZSH
sudo pacman -S zsh zsh-completions
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/dotfiles/zsh/owlycode.zsh-theme ~/.oh-my-zsh/themes/owlycode.zsh-theme
chsh -s /bin/zsh


