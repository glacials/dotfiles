#!/usr/bin/env bash

set -euo pipefail
test -z ${DEBUG:-} || set -x

# This script installs casks, i.e. macOS apps available in Homebrew but not in
# the App Store.

. $(chezmoi source-path)/functions.sh

function cask() {
		# brew install on a cask installs even if alrady installed, so we'll skip
		# that ourselves if that's the case.

		# Strip the tap name; `brew list` doesn't want it
		pkg=$(echo "$1" | sed -e 's/.*\///')
		brew list "$pkg" >/dev/null || casks="${casks:-}$1 "
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
cask railwaycat/emacsmacport/emacs-mac # macOS-native Emacs UI
cask stay # Restore window positions when displays change
cask syncthing # Sync files between devices
cask visual-studio-code # Code editor
cask vlc # Video player

# Install all casks at once, to avoid the overhead of multiple invocations/
if ! test -z "${casks:-}"; then
		brew install --force --quiet ${casks}
fi
