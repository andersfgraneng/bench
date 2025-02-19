# Run setup for all modules

if [[ "$OSTYPE" =~ darwin* ]]; then
  echo "OS is: $OSTYPE"
  ./mac/setup.sh
  stow aerospace
  stow ghostty
  stow jetbrains
elif [[ "$OSTYPE" =~ linux-gnu ]]; then
  echo "OS is: $OSTYPE"

  if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    if [[ "$NAME" == "Arch Linux" ]]; then
      ./archlinux/setup.sh
    fi
  fi
fi

./tmux/setup.sh
./zsh/setup.sh

stow nvim
stow starship
stow tmux
stow zsh

echo "Install tpm plugins"
bash "$HOME/.tmux/plugins/tpm/bin/install_plugins"
