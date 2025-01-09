# Run setup for all modules

if [[ "$OSTYPE" == "darwin*" ]]; then
  ./mac/setup.sh
  stow aerospace
  stow ghostty
  stow jetbrains
fi

./tmux/setup.sh
./zsh/setup.sh

stow nvim
stow tmux
stow zsh
