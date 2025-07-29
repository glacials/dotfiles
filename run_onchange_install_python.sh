#!/bin/bash

set -euo pipefail
test -z ${DEBUG:-} || set -x
uname=$(uname -s | tr "[:upper:]" "[:lower:]")

# This script installs Python and several tools in the Python ecosystem.
echo "Installing Python and friends"

. $(chezmoi source-path)/functions.sh

if [[ $uname == darwin ]]; then
	# Runtime dependencies of pyenv (https://github.com/pyenv/pyenv/wiki#suggested-build-environment)
	pkginstall make build-essential libssl-dev zlib1g-dev \
	libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
	libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
 
	npm install -g pyright # Language server
	install_now pyenv pyenv-virtualenv
fi
