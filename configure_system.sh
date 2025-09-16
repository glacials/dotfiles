#!/bin/bash

set -euo pipefail
test -z ${DEBUG:-} || set -x
DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# This script sets miscellaneous system preferences.
echo "Setting preferences"

. $DOTFILES_DIR/functions.sh

# Create $HOME/.profile (for secret things that shouldn't go in this repo)
touch $HOME/.profile

if [[ $uname == darwin ]]; then
	# Show full paths in footer of Finder windows
	defaults write com.apple.finder ShowPathbar -bool true

	# Point ~/icloud to iCloud Drive, if iCloud Drive is on
	icloud_enabled=$(
		defaults read MobileMeAccounts Accounts 2>/dev/null \
		| plutil -convert json -o - - \
		| jq -e '.[0].Services[] | select(.Name == "MOBILE_DOCUMENTS") | .Enabled == 1' >/dev/null && echo 1 || echo 0
	)
	
	if [[ "$icloud_enabled" == "1" ]]; then
		if ! test -e ~/icloud; then
			ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs ~/icloud
		fi
	fi
fi
