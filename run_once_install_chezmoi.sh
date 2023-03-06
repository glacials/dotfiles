#!/bin/bash

set -euo pipefail
test -z ${DEBUG:-} || set -x

# This script installs Chezmoi. It is used by bootstrap.sh to get the rest of
# the dotfiles repo initialized and in a state to be invoked for a full machine
# install.
#
# I used to use Chezmoi's official installation command here:
#
#     sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply glacials
#
# However, I ran into issues with this on some machine types like Amazon Linux.
# So this file instead directly invokes the machine's package manager to install
# Chezmoi.

cdn="https://raw.githubusercontent.com/glacials/dotfiles/main"
f="functions.sh"
d="$(dirname $0)"
test -f $d/$f && . $d/$f || . <(curl -s $cdn/$f)

install_package_now "chezmoi"
chezmoi init --apply glacials
