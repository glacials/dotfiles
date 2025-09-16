#!/bin/bash

set -euo pipefail
test -z ${DEBUG:-} || set -x
uname=$(uname -s | tr "[:upper:]" "[:lower:]")
DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if [[ $uname != darwin ]]; then
    exit 0
fi

macosversion=$(sw_vers -productVersion | cut -d. -f1)

# This script installs macOS apps from the app store. Note that because of App
# Store API limitations, this script can only install apps that have previously
# been installed by the current user's Apple ID.
echo "Installing App Store apps"

. $DOTFILES_DIR/functions.sh

install_now mas # macOS App Store CLI

list=$(mas list)
appids_to_install=""
function app() {
    # mas install installs the app even if it is already installed, so we'll
    # skip those manually here.
    app_id=$1
    if [[ "$list" != *"$app_id"* ]]; then
        appids_to_install="$appids_to_install$app_id "
    fi
}

app 409183694  # Keynote
app 409201541  # Pages
app 409203825  # Numbers
app 409907375  # Apple Remote Desktop
app 411643860  # DaisyDisk
app 424389933  # Final Cut Pro
app 497799835  # Xcode
app 668208984  # GIPHY Capture
app 747648890  # Telegram
app 775737590  # iA Writer
app 920404675  # Monodraw
app 1046095491 # Freeze - for Amazon Glacier
app 1085114709 # Parallels Desktop
app 1118136179 # AutoMute
app 1147396723 # WhatsApp Desktop
app 1233861775 # Acorn
app 1246969117 # Steam Link
app 1475387142 # Tailscale
app 1478821913 # GoLinks for Safari
app 1480068668 # Messenger
app 1480933944 # Vimari
app 1507890049 # Pixeur
app 1518425043 # Boop
app 1534275760 # LanguageTool
app 1569813296 # 1Password for Safari

if ! test -z "${appids_to_install:-}"; then
    mas install $appids_to_install
fi
