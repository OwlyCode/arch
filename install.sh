#!/bin/bash

set -e

sudo -v

CURRENT=$(pwd)

# GIT
rm ~/.gitconfig
ln -s $CURRENT/git/git.conf ~/.gitconfig

# Alacritty
sudo snap install --classic alacritty

if [ ! -e $HOME/.alacritty.toml ]; then
  ln -s $CURRENT/alacritty.toml ~/.alacritty.toml
fi

# Z
if [ ! -d ~/.rupaz ]; then
  git clone git@github.com:rupa/z.git ~/.rupaz
fi

# ZSH
sudo apt install -y zsh

if [ ! -e $HOME/.zshrc ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"
  rm ~/.zshrc
  ln -s $CURRENT/zsh/zshrc ~/.zshrc
fi

# Pure
if [ ! -e $HOME/.zsh ]; then
  mkdir -p "$HOME/.zsh"
  git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
fi

sudo chsh -s $(which zsh) $(whoami)

if [ ! -e /usr/local/bin/got ]; then
  sudo ln -s $CURRENT/zsh/got /usr/local/bin/got
fi

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
sudo apt install -y ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick
cargo install --locked yazi-fm yazi-cli zellij
sudo snap install --classic helix

# Helix
rm -rf ~/.config/helix
mkdir -p ~/.config/helix
ln -s $CURRENT/helix/config.toml ~/.config/helix/config.toml
ln -s $CURRENT/helix/themes ~/.config/helix/themes

# Zellij
rm -f ~/.config/zellij/config.kdl
mkdir -p ~/.config/zellij
ln -s $CURRENT/zellij/config.kdl ~/.config/zellij/config.kdl

# Atuin
bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)
