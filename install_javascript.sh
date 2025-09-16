#!/bin/bash

set -euo pipefail
test -z ${DEBUG:-} || set -x
uname=$(uname -s | tr "[:upper:]" "[:lower:]")
DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if [[ $uname == linux ]]; then
exit 0
fi

# This script installs JavaScript and several tools in the JavaScript ecosystem.
echo "Installing JavaScript and friends"

. $DOTFILES_DIR/functions.sh

if [[ $uname == linux ]]; then
	curl -fsSL https://github.com/nodenv/nodenv-installer/raw/HEAD/bin/nodenv-installer | bash
else
	install_now nodenv
fi

# Modern way to install yarn
corepack enable

latest=$(\
nodenv install --list 2>/dev/null | \
sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}' \
)
nodenv install --skip-existing $latest
nodenv global $latest

install_now npm
npm install -g \
bower `# package manager` \
prettier `# code formatter` \
prettier-plugin-go-template `# format go templates in HTML` \
typescript `# typed JavaScript`
