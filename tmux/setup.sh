#!/usr/bin/env zsh

echo "\nSetup tmux\n----------"
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  echo "Tpm already installed."
fi

if [[ ! -f "$HOME/.tmux.conf" ]]; then
  ln -s "${0:a:h}/.tmux.conf" "${HOME}/.tmux.conf"
  echo "Creating symlink for ~/.tmux.conf"
else
  echo "~/.tmux.conf already exists."
fi
