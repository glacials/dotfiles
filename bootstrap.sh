#!/bin/bash

set -euo pipefail
test -z ${DEBUG:-} || set -x

# This script is meant to be run before the user has the dotfiles repository
# cloned, as the first and only step in the installation process.
#
# Its goals are therefore:
#
# 1. Install Chezmoi if needed
# 2. Set up Chezmoi to work with the repository if needed
#   a. To use SSH to clone the repo, we need to set up an SSH key and put it in GitHub.
#   b. To put an SSH key in GitHub, we'll use the `gh` CLI.
#   c. To install the `gh` CLI, we need Homebrew.

cdn="https://raw.githubusercontent.com/glacials/dotfiles/main"
d=$(dirname $0)
f="functions.sh"
test -f $d/$f && . $d/$f || (curl -s "$cdn/$f" > /tmp/$f && source /tmp/$f)
h="run_once_install_homebrew.sh"
test -f $d/$h && . $d/$h || (curl -s "$cdn/$h" > /tmp/$h && source /tmp/$h)
uname=$(uname -s | tr "[:upper:]" "[:lower:]")

if [[ $uname == linux ]]; then
  if apt-get --version 1>/dev/null 2>/dev/null; then
    sudo snap install --classic chezmoi 2>/dev/null || sh -c "$(curl -fsLS get.chezmoi.io)"
  else
   sudo yum install -y chezmoi
  fi
else
  brew install --quiet --force chezmoi
fi
  
chezmoi init --apply glacials

cd $(chezmoi source-path)
git submodule init
git submodule update
chezmoi update
