#!/usr/bin/env zsh

echo "\nSetup aerospace\n----------"

if [[ ! -f "$HOME/.aerospace.toml" ]]; then
  ln -s "${0:a:h}/.aerospace.toml" "$HOME/.aerospace.toml"
  echo "Creating symlink for ~/.aerospace.toml"
else
  echo "~/.aerospace.toml already exists."
fi
