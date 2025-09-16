#!/bin/bash

set -euo pipefail
test -z ${DEBUG:-} || set -x

# This script is meant to be run before the user has the dotfiles repository
# cloned, as the first and only step in the installation process.
#
# Its goals are therefore:
#
# 1. To use SSH to clone the repo, we need to set up an SSH key and put it in GitHub.
# 2. To put an SSH key in GitHub, we'll use the `gh` CLI.
# 3. To install the `gh` CLI, we need Homebrew.

cdn="https://raw.githubusercontent.com/glacials/dotfiles/main"
d=$(dirname $0)
f="functions.sh"
test -f $d/$f && . $d/$f || (curl -s "$cdn/$f" > /tmp/$f && source /tmp/$f)
h="run_once_install_homebrew.sh"
test -f $d/$h && . $d/$h || (curl -s "$cdn/$h" > /tmp/$h && source /tmp/$h)
uname=$(uname -s | tr "[:upper:]" "[:lower:]")
  
mkdir -p ~/pj
git clone git@github.com:glacials/dotfiles ~/pj/dotfiles
cd ~/pj/dotfiles
stow nvim stow zsh
