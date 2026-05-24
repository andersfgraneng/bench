#!/usr/bin/env zsh

./tmux/setup.sh
./zsh/setup.sh

stow ghostty
stow mise
stow nvim
stow zed
stow starship
stow tmux
stow zsh

echo "Install tpm plugins"
bash "$HOME/.tmux/plugins/tpm/bin/install_plugins"

echo 'Set Screenshot folder to ~/Downloads'
defaults write com.apple.screencapture location ~/Downloads
killall SystemUIServer

echo "Finder: show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "cmd+shift+left and cmd+shift+right to move apps to left and right of the screen"
defaults write -globalDomain NSUserKeyEquivalents -dict-add "Move Window to Left Side of Screen" "@$\\U2190"
defaults write -globalDomain NSUserKeyEquivalents -dict-add "Move Window to Right Side of Screen" "@$\\U2192"

echo "Adjust mouse speed to 6.0"
defaults write -g com.apple.mouse.scaling 6.0

echo "Allow holding key/ disable holding for accented character"
defaults write -g ApplePressAndHoldEnabled -bool false

# Check if Homebrew is installed
command -v brew >/dev/null 2>&1 || { \
	echo >&2 "Installing Homebrew Now"; \
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; \
}

brew update
brew bundle --file="$(dirname "$0")/Brewfile"

if [ -d "$HOME/workbench/" ]; then
    . "$HOME/workbench/install.sh"
fi
