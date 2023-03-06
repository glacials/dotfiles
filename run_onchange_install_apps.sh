#!/usr/bin/env bash

set -euo pipefail
test -z ${DEBUG:-} || set -x

# This script installs macOS apps from the app store. Note that because of App
# Store API limitations, this script can only install apps that have previously
# been installed by the current user's Apple ID.

. $(chezmoi source-path)/functions.sh

if [[ $uname == darwin ]]; then
		install_now mas # macOS App Store CLI

    mas install \
				408981434  `# iMovie` \
        409183694  `# Keynote` \
        409201541  `# Pages` \
        409203825  `# Numbers` \
        411643860  `# DaisyDisk` \
        424389933  `# Final Cut Pro` \
        430798174  `# HazeOver` \
        441258766  `# Magnet` \
        497799835  `# Xcode` \
        747648890  `# Telegram` \
        775737590  `# iA Writer` \
        883878097  `# Server` \
        920404675  `# Monodraw` \
        1046095491 `# Freeze - for Amazon Glacier` \
        1085114709 `# Parallels Desktop` \
        1233861775 `# Acorn` \
        1246969117 `# Steam Link` \
        1451544217 `# Adobe Lightroom` \
        1475387142 `# Tailscale` \
        1478821913 `# GoLinks for Safari` \
        1480068668 `# Messenger` \
        1480933944 `# Vimari` \
        1482454543 `# Twitter` \
        1507890049 `# Pixeur` \
        1518425043 `# Boop` \
        1534275760 `# LanguageTool` \
        1569813296 `# 1Password for Safari` \
				2>/dev/null
fi
