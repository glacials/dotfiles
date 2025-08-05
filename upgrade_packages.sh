#!/bin/bash

set -euo pipefail
test -z ${DEBUG:-} || set -x

# This script installs/updates the packages installed on the system. It is
# designed to be run occasionally.
echo "Upgrading packages"

. $(chezmoi source-path)/functions.sh

[[ ${debug:-} == "y" ]] && echo "Updating packages."

if [[ $uname == darwin ]]; then
  brew update
  brew upgrade
else
  if . /etc/os-release && [ "$ID_LIKE" = "debian" ]; then
    sudo apt-get --quiet --quiet update
    sudo apt-get --quiet --quiet upgrade
  fi
fi
