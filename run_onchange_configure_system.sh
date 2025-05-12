#!/bin/bash

set -euo pipefail
test -z ${DEBUG:-} || set -x

# This script sets miscellaneous system preferences.
echo "Setting preferences"

. $(chezmoi source-path)/functions.sh

# Create $HOME/.profile (for secret things that shouldn't go in this repo)
touch $HOME/.profile

# Change to zsh if needed
if [[ $SHELL != */zsh ]]; then
	install_now zsh
	chsh -s /bin/zsh $(whoami)
fi

if [[ $uname == darwin ]]; then
    # Show full paths in footer of Finder windows
    defaults write com.apple.finder ShowPathbar -bool true

		# Point ~/icloud to iCloud Drive
		if [[ "${USER}" == "glacials" ]]; then
			 # Since work usually disables it, above is an approximation of "is iCloud on?"
				if ! test -e ~/icloud; then
						ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs ~/icloud
				fi
		fi

		# Better cron for macOS (smartly handles sleep etc.)
    mkdir -p ~/Library/LaunchAgents
    ln -fs $(chezmoi source-path)/LaunchAgents/* ~/Library/LaunchAgents
fi

# Cron et al.
crontab "$(chezmoi source-path)/cron"
