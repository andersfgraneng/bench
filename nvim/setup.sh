#!/usr/bin/env zsh

echo "\nSetup neovim\n----------"
if [[ ! -d "$HOME/.config/nvim" ]]; then
  ln -s "${0:a:h}" "${HOME}/.config/nvim"
  echo "Creating symlink for ~/.config/nvim"
else
  echo "~/.config/nvim already exists."
fi
