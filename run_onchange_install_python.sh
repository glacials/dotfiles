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

		if [[ -d "/home/linuxbrew" ]]; then
        linuxbrew_home="/home/linuxbrew/.linuxbrew"
    else
        linuxbrew_home="$HOME/.linuxbrew"
    fi
    export LDFLAGS="-L$linuxbrew_home/opt/openssl@3/lib"
    export CPPFLAGS="-I$linuxbrew_home/opt/openssl@3/include"

	npm install -g pyright # Language server
	install_now pyenv pyenv-virtualenv
	latest=$(\
      pyenv install --list 2>/dev/null | \
      sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}' \
    )
	pyenv install --skip-existing $latest
	pyenv global $latest
fi
