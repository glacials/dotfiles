#!/usr/bin/env bash

set -euo pipefail
test -z ${DEBUG:-} || set -x

# This script installs various CLI tools.

. $(chezmoi source-path)/functions.sh

brew install --quiet --force \
		 ack `# A better grep` \
		 awscli `# AWS CLI` \
		 bash `# macOS ships with an olerd version` \
		 chezmoi `# Probably already installed, but for good measure` \
		 cowsay `# Make animals say things` \
		 difftastic `# A better diff` \
		 direnv `# Auto-source .envrc files` \
		 fd `# A better find` \
		 ffmpeg `# Image and video manipulation` \
		 fortune `# Random quotes` \
		 fzf `# Fuzzy finder` \
		 gh `# GitHub CLI` \
		 git `# macOS ships with an older version` \
		 imagemagick `# Image manipulation` \
		 jq `# JSON manipulation` \
		 nvim `# Neovim` \
		 railwaycat/emacsmacport/emacs-mac `# macOS-native Emacs UI` \
		 ripgrep `# A better grep` \
		 starship `# Opinionated pre-configured prompt` \
		 syncthing `# Sync files between devices` \
		 tmux `# Terminal multiplexer` \
		 tree `# Pretty-print directory hierarchies` \
		 watch `# Run a command repeatedly` \
		 visual-studio-code `# Code editor` \
		 wget `# Download files` \
		 youtube-dl `# Download videos from YouTube` \
		 zsh `# macOS ships with an older version`

# Misc followups to above
brew services start syncthing
sh ~/.config/fortune/strfile

# Make a fortune database from bash.org quotes
MINSCORE=500
sqlite3 \
		../sql/sqlite3.db \
		"select quote from quotes where score > $MINSCORE" \
		| sed -E 's/^$/%/' > ./dot_config/fortune/bashorg
strfile ./dot_config/fortune/bashorg
