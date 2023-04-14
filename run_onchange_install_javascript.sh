#!/bin/bash

set -euo pipefail
test -z ${DEBUG:-} || set -x

# This script installs JavaScript and several tools in the JavaScript ecosystem.
echo "Installing JavaScript and friends"

. $(chezmoi source-path)/functions.sh

install_now nodenv npm

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
