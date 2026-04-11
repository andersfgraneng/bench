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
sudo pacman -S --noconfirm --needed sudo man-db less vi vim
sudo pacman -S --noconfirm --needed zsh
sudo pacman -S --noconfirm --needed which
sudo pacman -S --noconfirm --needed openssh

#Build dependencies for: python w pyenv, sdkman needs unzip and zip
sudo pacman -S --noconfirm --needed base-devel openssl zlib xz tk
sudo pacman -S --noconfirm --needed unzip zip
sudo pacman -S --noconfirm --needed wget

# install programming languages tooling
sudo pacman -S --noconfirm --needed go
sudo pacman -S --noconfirm --needed rustup

if [[ ! -f "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
    curl -s "https://get.sdkman.io" | bash
else
    echo "sdkman already installed."
fi

if [[ ! -d "$HOME/.nvm" ]]; then
    PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash'
else
    echo "nvm already installed."
fi

if [[ ! -d "$HOME/.pyenv" ]]; then
    curl -fsSL https://pyenv.run | bash
else
    echo "pyenv already installed."
fi

if [[ "$SHELL" != "/usr/bin/zsh" ]]; then
  chsh -s /usr/bin/zsh
fi

# Add 1password

ARCH="amd64" && \
wget "https://cache.agilebits.com/dist/1P/op2/pkg/v2.30.3/op_linux_${ARCH}_v2.30.3.zip" -O op.zip && \
unzip -d op op.zip && \
sudo mv op/op /usr/local/bin/ && \
rm -r op.zip op && \
sudo groupadd -f onepassword-cli && \
sudo chgrp onepassword-cli /usr/local/bin/op && \
sudo chmod g+s /usr/local/bin/op
