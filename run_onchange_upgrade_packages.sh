#!/usr/bin/env bash

set -euo pipefail
test -z ${DEBUG:-} || set -x

# This script installs updates the packages installed on the system. It is
# designed to be run occasionally.

. $(chezmoi source-path)/functions.sh

[[ $debug == "y" ]] && echo "Updating packages."

upgrade
