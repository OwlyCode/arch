#!/bin/bash

set -ex

sudo -v

# 32BITS SUPPORT (uncomment if needed)
#echo "[multilib]" | sudo tee -a /etc/pacman.conf
#echo "Include = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf
#sudo pacman -Syu

# BASIC TOOLS
sudo pacman -S openssh htop vim wget which unrar unzip gzip

# GRAPHICAL ENVIRONMENT
sudo pacman -S xorg-server xorg-xinit xorg-server-utils
sudo pacman -S xorg-fonts-type1 ttf-dejavu artwiz-fonts font-bh-ttf \
          font-bitstream-speedo gsfonts sdl_ttf ttf-bitstream-vera \
          ttf-cheapskate ttf-liberation adobe-source-code-pro-fonts
sudo pacman -S lightdm lightdm-gtk-greeter
sudo pacman -S budgie-desktop gnome-control-center

sudo cp ~/dotfiles/xorg/keyboard.conf /etc/X11/xorg.conf.d/10-keyboard-layout.conf

sudo systemctl enable lightdm

reboot
