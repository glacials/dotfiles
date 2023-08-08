#!/bin/bash

set -euo pipefail
test -z ${DEBUG:-} || set -x
uname=$(uname -s | tr "[:upper:]" "[:lower:]")

if [[ $uname == linux ]]; then
	exit 0
fi

# This script installs casks, i.e. macOS apps available in Homebrew but not in
# the App Store.
echo "Installing casks"

. $(chezmoi source-path)/functions.sh

# Save the `brew list` output so we don't have to call out to brew so much
brewlist=$(brew list --casks)
function cask() {
		# brew install on a cask installs even if alrady installed, so we'll skip
		# it ourselves if that's the case.

		pkg_with_tap=$1
		pkg=$(echo "$pkg_with_tap" | sed -e 's/.*\///')
		if [[ "$brewlist" != *"$pkg"* ]]; then
			casks="${casks:-}$pkg_with_tap "
		fi
}

cask 1password # Password manager
cask discord # Chat app
cask docker # Containerization
cask firefox # Browser
cask homebrew/cask-fonts/font-hack-nerd-font # Nerd fonts
cask homebrew/cask-fonts/font-jetbrains-mono # JetBrains Mono font
cask homebrew/cask-fonts/font-source-code-pro # Source Code Pro font
cask google-chrome # Browser
cask iterm2 # Terminal emulator
cask kitty # Terminal emulator
cask launchcontrol # App launcher
# cask railwaycat/emacsmacport/emacs-mac # macOS-native Emacs UI
cask stay # Restore window positions when displays change
cask visual-studio-code # Code editor
cask vlc # Video player

# Install all casks at once, to avoid the overhead of multiple invocations
if ! test -z "${casks:-}"; then
	# --cask forces casks when there are options for formulae (e.g. docker, syncthing)
  brew install --cask --force --quiet ${casks}
fi

# Follow-ups
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.config/iterm2"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
