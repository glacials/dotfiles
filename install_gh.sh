#!/bin/bash

set -euo pipefail
test -z ${DEBUG:-} || set -x
DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

CACHE_KEY=/tmp/glacials/dotfiles/cache/gh
test -f $CACHE_KEY && exit 0

# This script installs gh, the GitHub CLI. This is helpful to be in its own
# script because we use it to install an SSH key into GitHub, which is one of
# the first steps of bootstrapping before we can clone the rest of the repo.
echo "Installing gh"

cdn="https://raw.githubusercontent.com/glacials/dotfiles/main"
f="functions.sh"
d=$DOTFILES_DIR
test -f $d/$f && . $d/$f || (curl -s "$cdn/$f" > /tmp/$f && . /tmp/$f)

if ! gh --version 1>/dev/null 2>/dev/null; then
	# Install Homebrew
	run_script run_once_install_homebrew.sh
	install_now gh
fi

mkdir -p /tmp/glacials/dotfiles/cache
touch $CACHE_KEY
