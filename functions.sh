#!/bin/bash

set -euo pipefail
test -z ${DEBUG:-} || set -x

# This script defines several functions used by other scripts. It does not do
# anything on its own.
#
# To import these functions in another script, use the following snippet:
#
#     cdn="https://raw.githubusercontent.com/glacials/dotfiles/main"
#     f="functions.sh"
#     d="$(dirname $0)
#     test -f $d/$f && . $d/$f || . <($curl -fsSL $cdn/$f)
#
# This will import the functions whether or not the dotfiles repo has been
# cloned yet.
#
# TODO: Prevent downloading this multiple times from multiple locations, before
# the repo is cloned.

uname=$(uname -s | tr "[:upper:]" "[:lower:]")
if [[ $uname == linux ]]; then
    if apt-get --version 1>/dev/null 2>/dev/null; then
        pkgmgr="apt-get"
        pkgins="sudo $pkgmgr install -y"
    else
        pkgmgr="yum"
        pkgins="sudo $pkgmgr install -y"
    fi
else
    pkgmgr="brew"
    pkgins="$pkgmgr install --quiet --force"
fi

# run_script runs a script from the dotfiles repo. The first argument must be
# $0, i.e. the directory of the running script. The second argument is the name
# of the script to run, relative to that directory.
#
# If the script is available locally it is run directly. If not, it is
# downloaded and run. This is helpful when bootstrapping, as the dotfiles repo
# may not be cloned yet.
function run_script() {
    if test -f "$(dirname "$0")/$1"; then
        sh $(dirname "$0")/$1
    else
        sh -c "$($curl $cdn/$1)"
    fi
}

function install_package() {
    $pkgins $1
}
