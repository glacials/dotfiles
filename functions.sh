#!/bin/bash

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
cpu=$(uname -m)
function pkginstall() {
	if [[ $uname == linux ]]; then
		if apt-get --version 1>/dev/null 2>/dev/null; then
			if [[ $1 == chezmoi || $1 == go ]]; then
				sudo snap install --classic $1 2>/dev/null || sudo apt-get install golang
			elif [[ $1 == gh && cpu == armv7l && uname == linux ]]; then
				type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
				curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
				&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
				&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
				&& sudo apt update \
				&& sudo apt install gh -y
			else
				sudo apt-get install -y $1
			fi
		else
			sudo yum install -y $1
		fi
	else
		brew install --quiet --force $1
	fi
}

# run_script runs a script from the dotfiles repo once.
# If run_script has already run the script during this invocation,
# it noops instead.
# The first and only argument
# is the name of the script to run, relative to the dotfiles repo root.
#
# If the script is available locally it is run directly. If not, it is
# downloaded and run. This is helpful when bootstrapping, as the dotfiles repo
# may not be cloned yet.
function run_script() {
	if test -f "$(chezmoi source-path)/$1"; then
		test -z ${DEBUG:-} ||	echo "Running $1 locally"
		bash "$(chezmoi source-path)/$1"
	else
		test -z ${DEBUG:-} || echo "Running $1 from GitHub"
		bash -c "$(curl -fsSL $cdn/$1)"
	fi
}

# install_now immediately installs a package using the right package
# manager for the current system.
#
# This should only be used if the package is required during the dotfiles
# installation process. Otherwise, prefer install to avoid the overhead
# of invoking the package manager multiple times.
function install_now() {
	test -z ${1:-} || pkginstall $1
}

# install installs a package using the right package manager for the
# current system.
#
# The installation is deferred until the end of the run so as to avoid the
# overhead of invoking the package manager multiple times. If you need a package
# right away, use install_now.
function install() {
	pkgs="${pkgs:-} $1"
}
trap install_now ${pkgs:-} EXIT
