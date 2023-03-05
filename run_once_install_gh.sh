#!/bin/bash

# This script installs gh, the GitHub CLI. This is helpful to be in its own
# script because we use it to install an SSH key into GitHub, which is one of
# the first steps of bootstrapping before we can clone the rest of the repo.

cdn="https://raw.githubusercontent.com/glacials/dotfiles/main"
f="functions.sh"
test -f $0/$f && . $0/$f || . <($curl -fsSL $cdn/$f)

if ! gh --version 1>/dev/null 2>/dev/null; then
    # Install Homebrew
    run_script run_once_install_homebrew.sh
    $brewinstall gh
fi
