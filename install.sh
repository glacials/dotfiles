#!/bin/bash
set -euo pipefail
set -x # uncomment to print all commands as they happen

uname=$(uname -s | tr "[:upper:]" "[:lower:]")
pwd=$(pwd)

apt="sudo apt-get --quiet --quiet --assume-yes"
if [[ $uname == linux* ]]; then
  brew="$HOME/.linuxbrew/bin/brew"
else
  brew="brew"
fi
brewinstall="$brew install --quiet"
npm="npm --silent"

# This script is idempotent! It is safe to re-run at any time.
#
# If you're setting up a machine for the first time, you should do the following manual steps after running this file:
#
# 1. gpg --gen-key
# 2. In the output note the key under the line starting with "pub" (you can re-access this later with gpg --list-keys).
# 3. git config --global user.signingkey KEY_NOTED_FROM_ABOVE
# 4. gpg --armor --export | pbcopy
# 5. Paste that in https://github.com/settings/gpg/new
#
# (partly from https://gist.github.com/bmhatfield/cc21ec0a3a2df963bffa3c1f884b676b)
#
# TODO: Refactor so we only need to invoke `brew install` once.

########################################## Start symlinks
echo "Setting up symbolic links."


# Symlinks
# Note: If creating a symlink to something in a subdirectory of ~, first mkdir -p that directory.
mkdir -p $HOME/.config
[ -h $HOME/.ackrc ]                && ln -fs $(pwd)/.ackrc                $HOME         || ln -is $(pwd)/.ackrc                $HOME
[ -h $HOME/.amethyst ]             && ln -fs $(pwd)/.amethyst             $HOME         || ln -is $(pwd)/.amethyst             $HOME
[ -h $HOME/.config/nvim ]          && ln -fs $(pwd)/.config/nvim          $HOME/.config || ln -is $(pwd)/.config/nvim          $HOME/.config
[ -h $HOME/.gitconfig ]            && ln -fs $(pwd)/.gitconfig            $HOME         || ln -is $(pwd)/.gitconfig            $HOME
[ -h $HOME/.gitignore_global ]     && ln -fs $(pwd)/.gitignore_global     $HOME         || ln -is $(pwd)/.gitignore_global     $HOME
########################################## End symlinks

########################################## Start package managers
echo "Setting up package managers."

if [[ $uname == linux* ]]; then
  $apt update
  $apt upgrade
  $apt install zsh
fi

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Update path for Homebrew for Linux since we can't source .zshrc yet
export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
export PATH=$HOME/.linuxbrew/bin:$PATH

if [[ $uname == linux* ]]; then
  $apt install -y build-essential # Homebrew asks for this on install
fi
$brewinstall gcc
$brew update
$brew upgrade
echo "Ignore above messages re: gcc and build-essential; it is done."
########################################## End package managers

########################################## Start languages
echo "Setting up languages."

# JavaScript
$brewinstall npm
$npm install -g typescript bower

# Python
if [[ $uname == linux* ]]; then
  #   Runtime dependencies of pyenv (https://github.com/pyenv/pyenv/wiki#suggested-build-environment)
  $apt install make build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
fi
$npm install -g pyright # Language server
$brewinstall pyenv pyenv-virtualenv # pyenv

# Ruby
$brewinstall rbenv ruby-build
########################################## End languages

########################################## Start application installations
echo "Starting application installations."

$brewinstall awscli direnv nvim

# Neovim & plugin dependencies
$brewinstall fd ripgrep

# Fortune
$brewinstall fortune cowsay
./fortunes/strfile
########################################## End application installations

########################################## Start shell configuration
# Create $HOME/.profile (to put secret things, that shouldn't go in this repository)
touch $HOME/.profile

# Install oh-my-zsh
rm -rf $HOME/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh --unattended)"
rm -rf $HOME/.oh-my-zsh
[ -h $HOME/.oh-my-zsh ] && ln -fs $(pwd)/.oh-my-zsh $HOME || ln -is $(pwd)/.oh-my-zsh $HOME

# Change to zsh and replace session
chsh -s /bin/zsh `whoami`
rm -f $HOME/.zshrc
[ -h $HOME/.zshrc ] && ln -fs $(pwd)/.zshrc $HOME || ln -is $(pwd)/.zshrc $HOME
zsh
########################################## End shell configuration

########################################## Start manual setup

echo "Some manual steps are still required:"
echo "  - Open iTerm2 prefs → General → Preferences and load from ./preferences/iterm
echo "  - Download Nord color scheme for iTerm2: https://github.com/arcticicestudio/nord-iterm2"
echo ""
echo "That's it!"
