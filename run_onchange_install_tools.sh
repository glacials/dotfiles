#!/usr/bin/env bash

set -euo pipefail
test -z ${DEBUG:-} || set -x

# This script installs various CLI tools.
echo "Installing CLI tools"

. $(chezmoi source-path)/functions.sh

brew install --quiet --force \
		 ack `# A better grep` \
		 awscli `# AWS CLI` \
		 bash `# macOS ships with an olerd version` \
		 chezmoi `# Probably already installed, but for good measure` \
		 cowsay `# Make animals say things` \
		 defaultbrowser `# Set default web browser from CLI` \
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
		 ripgrep `# A better grep` \
		 starship `# Opinionated pre-configured prompt` \
		 tmux `# Terminal multiplexer` \
		 tree `# Pretty-print directory hierarchies` \
		 watch `# Run a command repeatedly` \
		 wget `# Download files` \
		 youtube-dl `# Download videos from YouTube` \
		 zsh `# macOS ships with an older version`

# Misc followups to above
brew services start --quiet syncthing 1>/dev/null
sh ~/.config/fortune/strfile
defaultbrowser chrome
