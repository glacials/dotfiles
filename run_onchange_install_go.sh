#!/usr/bin/env bash

set -euo pipefail
test -z ${DEBUG:-} && set -x

# This script installs Go and several tools in the Go ecosystem.

. $(chezmoi source-path)/functions.sh

install_package_now go
goinstall="go install"
$goinstall golang.org/x/tools/gopls@latest # Language server
$goinstall github.com/segmentio/golines@latest # gofmt w/ line wrapping
