#!/bin/bash

set -euo pipefail
test -z ${DEBUG:-} || set -x
DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# This script installs Go and several tools in the Go ecosystem.
echo "Installing Go"

. $DOTFILES_DIR/functions.sh

install_now go

go install github.com/segmentio/golines@latest # gofmt w/ line wrapping
go install golang.org/x/tools/gopls@latest # Language server
