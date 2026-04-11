#!/bin/bash

# For arch you need to install the tools to get this repo
# pacman -S git sudo

sudo apt update

sudo snap install tmux
sudo snap install nvim
sudo apt install starship

sudo apt-add-repository -y ppa:lepapareil/hurl
sudo apt install hurl=7.0.0*

sudo apt install stow
sudo apt install openconnect
sudo apt install fd
sudo apt install jq
sudo apt install bat
sudo apt install tree
sudo apt install fzf
sudo apt install ripgrep
#sudo snap install terraform

# install programming languages tooling
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

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
