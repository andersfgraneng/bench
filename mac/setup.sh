#!/bin/bash

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

brew_cask_check_if_installed () {
	if brew ls --cask --versions $1 > /dev/null; then
		echo "$1 allready installed"
	else
		echo "$1 is not installed with brew cask"
		read -p "Install it? [yN] " -n 1 -r
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			echo
			echo "Installing $1"
			brew install --cask $1
		fi
	fi
}

brew update

brew install git
brew install tmux
brew install neovim
brew install starship
brew install hurl
brew install stow
brew install openconnect
brew install fd
brew install jq
brew install bat
brew install tree
brew install fzf
brew install ripgrep
brew install pyenv
brew install --cask iTerm2
brew install --cask ghostty
brew install --cask nikitabobko/tap/aerospace
brew install --cask arc
brew install --cask chatgpt
brew install --cask obsidian
brew install --cask raycast
brew install --cask google-cloud-sdk
brew tap FelixKratz/formulae
brew install borders
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

# install programming languages tooling
echo "Checking if Rust is installed"
if [[ ! -d "$HOME/.cargo" ]];then
    echo "Rust is not installed, installing..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
    echo "Rust is installed."
fi
