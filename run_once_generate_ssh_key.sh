#!/bin/bash

set -euo pipefail
test -n ${DEBUG:-} && set -x

# This script generates an SSH key for the user if needed, then puts it in
# GitHub and sets up gh to use it if needed.

cdn="https://raw.githubusercontent.com/glacials/dotfiles/main"
f="functions.sh"
d="$(dirname $0)"
test -f $d/$f && . $d/$ || curl -fsSL $cdn/$f | bash

sshkey="$HOME/.ssh/id_rsa"

if [[ ! -f $HOME/.ssh/id_rsa ]]; then
    ssh-keygen -f $sshkey -N ""
fi

run_script $0 run_once_install_gh.sh
if ! gh auth status 1>/dev/null 2>/dev/null; then
    gh auth login --git-protocol ssh --hostname github.com --web
fi