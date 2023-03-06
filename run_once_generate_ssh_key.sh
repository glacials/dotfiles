#!/usr/bin/env bash

set -euo pipefail
test -z ${DEBUG:-} || set -x

# This script generates an SSH key for the user if needed, then puts it in
# GitHub and sets up gh to use it if needed.

cdn="https://raw.githubusercontent.com/glacials/dotfiles/main"
f="functions.sh"
d="$(chezmoi source-path)"
test -f $d/$f && . $d/$f || (curl -s "$cdn/$f" > /tmp/$f && . /tmp/$f)

sshkey="$HOME/.ssh/id_rsa"

if ! test -f $HOME/.ssh/id_rsa; then
    ssh-keygen -f $sshkey -N ""
fi

run_script run_once_install_gh.sh
if ! gh auth status 1>/dev/null 2>/dev/null; then
    gh auth login --git-protocol ssh --hostname github.com --web
fi
