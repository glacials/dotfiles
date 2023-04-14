#!/bin/bash

set -euo pipefail
test -z ${DEBUG:-} || set -x
uname=$(uname -s | tr "[:upper:]" "[:lower:]")

# This script installs JavaScript and several tools in the JavaScript ecosystem.
echo "Installing JavaScript and friends"

. $(chezmoi source-path)/functions.sh

if [[ $uname == linux ]]; then
	curl -fsSL https://github.com/nodenv/nodenv-installer/raw/HEAD/bin/nodenv-installer | bash
else
	install_now nodenv
fi
install_now npm

latest=$(nodenv install --list 2>/dev/null | sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}')
nodenv install --skip-existing $latest
nodenv global $latest

npm install -g \
		bower `# package manager` \
		prettier `# code formatter` \
		prettier-plugin-go-template `# format go templates in HTML` \
		typescript `# typed JavaScript`

# Override for GitHub Copilot requirements
nodenv install --skip-existing 17.9.1
nodenv global 17.9.1
