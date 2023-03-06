#!/usr/bin/env bash
set -euo pipefail
# set -x # uncomment to print all commands as they happen

debug="" # set to y to enable more output

apt="sudo apt-get --quiet --quiet --assume-yes"
brew="brew"
brewinstall="$brew install --quiet --force"
npm="npm --silent"
yum="sudo yum --quiet --quiet --assumeyes"

########################################## Start package managers
[[ $debug == "y" ]] && echo "Setting up package managers."

if [[ $uname == linux* ]]; then
    $apt update
    $apt upgrade
    $apt install zsh
fi
########################################## End package managers

########################################## Start system configuration
# Create $HOME/.profile (to put secret things, that shouldn't go in this repository)
touch $HOME/.profile

# Install oh-my-zsh (manual method)
rm -rf $HOME/.oh-my-zsh
git clone --quiet https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

# Change to zsh if needed
if [[ $(echo $0) == linux* ]]; then
    chsh -s /bin/zsh $(whoami)
fi

if [[ $uname == darwin ]]; then
    # Show full paths in footer of Finder windows
    defaults write com.apple.finder ShowPathbar -bool true
fi

# Point ~/icloud to iCloud Drive
if [ ! -L ~/icloud ]; then
    ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs ~/icloud
fi

# Cron et al.
crontab ./cron
ln -s $(chezmoi source-path)/LaunchAgents/* ~/Library/LaunchAgents
########################################## End system configuration
