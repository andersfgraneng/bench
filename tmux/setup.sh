#!/usr/bin/env zsh

if [[ ! -d "$HOME/.tmux" ]]; then
  git clone https://github.com/gpakosz/.tmux.git "$HOME/.tmux"
  ln -s -f "$HOME/.tmux/.tmux.conf"
  cp "$HOME/.tmux/.tmux.conf.local" "$HOME"
fi

if [[ ! -d "$HOME/.config/tmux/plugins/catpuccin" ]]; then
  mkdir -p ~/.config/tmux/plugins/catppuccin
  git clone -b v2.1.0 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
fi
