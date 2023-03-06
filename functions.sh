#!/usr/bin/env bash

set -euo pipefail
test -z ${DEBUG:-} || set -x

# This script defines several functions used by other scripts. It does not do
# anything on its own.
#
# To import these functions in another script, use:
#
#     . $(dirname $0)/functions.sh
#
# To import these funcitons in a script that may or may not be running before
# the dotfiles repo has been cloned, use:
#
#     cdn="https://raw.githubusercontent.com/glacials/dotfiles/main"
#     f="functions.sh"
#     d="$(dirname $0)
#     test -f $d/$f && . $d/$f || (curl -s "$cdn/$f" > /tmp/$f && . /tmp/$f)
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

# run_script runs a script from the dotfiles repo. The first and only argument
# is the name of the script to run, relative to the dotfiles repo root.
#
# If the script is available locally it is run directly. If not, it is
# downloaded and run. This is helpful when bootstrapping, as the dotfiles repo
# may not be cloned yet.
function run_script() {
    if test -f "$(chezmoi source-path)/$1"; then
				test -z ${DEBUG:-} ||	echo "Running $1 locally"
        sh "$(chezmoi source-path)/$1"
    else
				test -z ${DEBUG:-} || echo "Running $1 from GitHub"
        sh -c "$(curl -fsSL $cdn/$1)"
    fi
}

# install_now immediately installs a package using the right package
# manager for the current system.
#
# This should only be used if the package is required during the dotfiles
# installation process. Otherwise, prefer install to avoid the overhead
# of invoking the package manager multiple times.
function install_now() {
    test -z ${1:-} || $pkgins $1
}
trap install_now ${pkgs:-} EXIT

# install installs a package using the right package manager for the
# current system.
#
# The installation is deferred until the end of the run so as to avoid the
# overhead of invoking the package manager multiple times. If you need a package
# right away, use install_now.
function install() {
    pkgs="${pkgs:-} $1"
}
