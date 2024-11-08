#!/usr/bin/env zsh

if [[ ! -d "$HOME/.tmux" ]]; then
  git clone https://github.com/gpakosz/.tmux.git "$HOME/.tmux"
  ln -s -f "$HOME/.tmux/.tmux.conf"
  cp "$HOME/.tmux/.tmux.conf.local" "$HOME"
fi
