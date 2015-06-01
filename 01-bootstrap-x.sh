#!/bin/bash

set -ex

sudo -v

sudo pacman -S openssh
sudo pacman -S xorg-server xorg-xinit xorg-server-utils
sudo pacman -S xorg-fonts-type1 ttf-dejavu artwiz-fonts font-bh-ttf \
          font-bitstream-speedo gsfonts sdl_ttf ttf-bitstream-vera \
          ttf-cheapskate ttf-liberation
sudo pacman -S lightdm lightdm-gtk-greeter
sudo pacman -S mate mate-extra mate-themes mate-themes-extras faenza-icon-theme

sudo cp ~/dotfiles/xorg/keyboard.conf /etc/X11/xorg.conf.d/10-keyboard-layout.conf

sudo systemctl enable lightdm

reboot
