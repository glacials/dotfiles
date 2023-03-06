#!/usr/bin/env bash

set -euo pipefail
test -z ${DEBUG:-} || set -x

# This script installs Go and several tools in the Go ecosystem.

. $(chezmoi source-path)/functions.sh

install_now go

go install github.com/segmentio/golines@latest # gofmt w/ line wrapping
go install golang.org/x/tools/gopls@latest # Language server
