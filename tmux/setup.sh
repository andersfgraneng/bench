#!/usr/bin/env zsh

if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [[ ! -d "$HOME/.config/tmux/plugins/catpuccin" ]]; then
  mkdir -p ~/.config/tmux/plugins/catppuccin
  git clone -b v2.1.0 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
fi
