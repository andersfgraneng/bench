#!/bin/bash

# For arch you need to install the tools to get this repo
# pacman -S git sudo

sudo pacman -Syu

sudo pacman -S --noconfirm --needed tmux
sudo pacman -S --noconfirm --needed neovim
sudo pacman -S --noconfirm --needed starship
sudo pacman -S --noconfirm --needed hurl
sudo pacman -S --noconfirm --needed stow
sudo pacman -S --noconfirm --needed openconnect
sudo pacman -S --noconfirm --needed fd
sudo pacman -S --noconfirm --needed jq
sudo pacman -S --noconfirm --needed bat
sudo pacman -S --noconfirm --needed tree
sudo pacman -S --noconfirm --needed fzf
sudo pacman -S --noconfirm --needed ripgrep
sudo pacman -S --noconfirm --needed terraform

#Shell
sudo pacman -S --noconfirm --needed git
sudo pacman -S --noconfirm --needed sudo 
sudo pacman -S --noconfirm --needed zsh
sudo pacman -S --noconfirm --needed which
sudo pacman -S --noconfirm --needed openssh

#Build dependencies for: python w pyenv
sudo pacman -S --noconfirm --needed base-devel openssl zlib xz tk

if [[ ! -d "$HOME/.pyenv" ]]; then
    curl -fsSL https://pyenv.run | bash
fi

if [[ "$SHELL" != "/usr/bin/zsh" ]]; then
  chsh -s /usr/bin/zsh
fi
