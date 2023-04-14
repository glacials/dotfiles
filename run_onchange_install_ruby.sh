#!/bin/bash

set -euo pipefail
test -z ${DEBUG:-} || set -x

# This script installs Ruby and several tools in the Ruby ecosystem.
test -z ${SKIP_RUBY:-} || exit 0
echo "Installing Ruby and friends"

. $(chezmoi source-path)/functions.sh

install_now rbenv ruby-build solargraph

latest=$(rbenv install --list 2>/dev/null | sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}')
rbenv install --skip-existing $latest
rbenv global $latest
