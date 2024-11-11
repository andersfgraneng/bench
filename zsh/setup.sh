#!/usr/bin/env zsh

echo "\nSetup zsh\n----------"
# Remember to import https://github.com/sindresorhus/iterm2-snazzy for colors
if [[ ! -d "$HOME/.zsh/pure" ]]; then
  mkdir -p "$HOME/.zsh"
  git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
else
  echo "Pure already installed."
fi

if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
  echo "zsh-syntax-highlighting already installed."
fi

if [[ ! -f "$HOME/.zshrc" ]]; then
  ln -s "${0:a:h}/.zshrc" "${HOME}/.zshrc"
  echo "Creating symlink for ~/.zshrc"
else
  echo "~/.zshrc already exists."
fi
