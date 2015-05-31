#!/bin/bash

set -ex

pacman -S openssh
pacman -S xorg-server xorg-xinit xorg-server-utils
pacman -S xorg-fonts-type1 ttf-dejavu artwiz-fonts font-bh-ttf \
          font-bitstream-speedo gsfonts sdl_ttf ttf-bitstream-vera \
          ttf-cheapskate ttf-liberation
pacman -S lightdm lightdm-gtk-greeter
pacman -S mate mate-extra mate-themes mate-themes-extras

cp xorg-keyboard.conf /etc/X11/xorg.conf.d/10-keyboard-layout.conf

systemctl enable lightdm

reboot

