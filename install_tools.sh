#!/bin/bash

set -euo pipefail
test -z ${DEBUG:-} || set -x
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# This script installs various CLI tools.
echo "Installing CLI tools"

. "$SCRIPT_DIR/functions.sh"

if [[ $uname == darwin ]]; then
  corepack enable `# Modern way to install yarn`

  brew install --quiet --force \
  ack `# A better grep` \
  awscli `# AWS CLI` \
  bash `# macOS ships with an olerd version` \
  bat `# A better cat` \
  cowsay `# Make animals say things` \
  defaultbrowser `# Set default web browser from CLI` \
  difftastic `# A better diff` \
  direnv `# Auto-source .envrc files` \
  dua-cli `# An interactive du` \
  eza `# A better ls` \
  fd `# A better find` \
  ffmpeg `# Image and video manipulation` \
  fortune `# Random quotes` \
  fzf `# Fuzzy finder` \
  gh `# GitHub CLI` \
  git `# macOS ships with an older version` \
  imagemagick `# Image manipulation` \
  jq `# JSON manipulation` \
  mosh `# A more reslient ssh` \
  nvim `# Neovim` \
  ripgrep `# A better grep` \
  starship `# Opinionated pre-configured prompt` \
  tmux `# Terminal multiplexer` \
  tree `# Pretty-print directory hierarchies` \
  tree-sitter `# tree-sitter library for editor language servers` \
  tree-sitter-cli `# tree-sitter CLI for editor language servers` \
  watch `# Run a command repeatedly` \
  wget `# Download files` \
  xh `# A better HTTP curl` \
  yazi `# Interactive file browser w/previews and Vim bindings` \
  youtube-dl `# Download videos from YouTube` \
  zellij `# A beginner-friendly tmux/screen` \
  zoxide `# A better cd`
  zsh `# macOS ships with an older version`
else
  if . /etc/os-release && [ "$ID" = "raspbian" ]; then
    sudo apt-get install --quiet --quiet \
    cowsay `# Make animals say things` \
    fortune `# Random quotes`
    
    # TODO: snap install snaps... somehow doesn't work when they're already installed, so
    # have to do one by one
    sudo snap install difftastic `# A better diff`
    sudo snap install nvim `# Neovim`
    
    # Opinionated pre-configured prompt
    starship --version 1>/dev/null 2>/dev/null || curl -sS https://starship.rs/install.sh | sh
  elif uname -r | grep -qi microsoft; then
    brew install --quiet --force \
    difftastic `# A better diff` \
    neovim `# Neovim` \
  else
    brew install --quiet --force \
    starship `# Opinionated pre-configured prompt`
  fi
fi

cargo install \
du-dust `# A better and faster du` \

# Misc followups to above
sh ~/.config/fortune/strfile
