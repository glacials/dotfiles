#!/bin/bash
set -euo pipefail
# set -x # uncomment to print all commands as they happen

debug="" # set to y to enable more output
uname=$(uname -s | tr "[:upper:]" "[:lower:]")

apt="sudo apt-get --quiet --quiet --assume-yes"
npm="npm --silent"

# Beware trying to base this on the current script; if the user is running without
# cloning (see README), this script's directory will not be the repository directory
dotfiles=$HOME/pj/dotfiles

# TODO: Refactor so we only need to invoke `brew install` once.

########################################## Start bootstrap
sshkey="$HOME/.ssh/id_rsa"
answer="n"

if [[ ! -d $HOME/pj/dotfiles ]]; then
  if [[ -f $HOME/.ssh/id_rsa ]]; then
    echo "Looks like you've already generated an SSH key."
    read -p "Is it in GitHub yet [y/N]? " answer
    answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')
  else
    ssh-keygen -f $sshkey -N ""
  fi

  if [[ $answer != "y" ]]; then
    # Need to install Homebrew to install gh to auth with GitHub to clone dotfiles :|
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew update --quiet
    brew install --quiet gh
    gh auth login --git-protocol ssh --hostname github.com --web
  fi

  git clone git@github.com:glacials/dotfiles $HOME/pj/dotfiles
fi
########################################## End bootstrap

########################################## Start symlinks
[[ $debug == "y" ]] && echo "Setting up symbolic links."


# Symlinks
# Note: If creating a symlink to something in a subdirectory of ~, first mkdir -p that directory.
mkdir -p $HOME/.config
[ -h $HOME/.ackrc ]                && ln -fs $dotfiles/.ackrc                $HOME         || ln -is $dotfiles/.ackrc                $HOME
[ -h $HOME/.amethyst ]             && ln -fs $dotfiles/.amethyst             $HOME         || ln -is $dotfiles/.amethyst             $HOME
[ -h $HOME/.config/nvim ]          && ln -fs $dotfiles/.config/nvim          $HOME/.config || ln -is $dotfiles/.config/nvim          $HOME/.config
[ -h $HOME/.gitconfig ]            && ln -fs $dotfiles/.gitconfig            $HOME         || ln -is $dotfiles/.gitconfig            $HOME
[ -h $HOME/.gitignore_global ]     && ln -fs $dotfiles/.gitignore_global     $HOME         || ln -is $dotfiles/.gitignore_global     $HOME
[ -h $HOME/.zshrc ]                && ln -fs $dotfiles/.zshrc                $HOME         || ln -is $dotfiles/.zshrc                $HOME
########################################## End symlinks

########################################## Start package managers
[[ $debug == "y" ]] && echo "Setting up package managers."

if [[ $uname == linux* ]]; then
  $apt update
  $apt upgrade
  $apt install zsh
fi

# Homebrew
brew help > /dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [[ $uname == linux* ]]; then
  if [[ -d "/home/linuxbrew" ]]; then
    brew="/home/linuxbrew/.linuxbrew/bin/brew"
  else
    brew="$HOME/.linuxbrew/bin/brew"
  fi
else
  brew="brew"
fi
brewinstall="$brew install --quiet"

# Update path for Homebrew for Linux since we can't source .zshrc yet
export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
export PATH=$HOME/.linuxbrew/bin:$PATH

if [[ $uname == linux* ]]; then
  $apt install -y build-essential # Homebrew asks for this on install
fi
$brewinstall gcc
$brew update --quiet
$brew upgrade --quiet
########################################## End package managers

########################################## Start languages
[[ $debug == "y" ]] && echo "Setting up languages."

# Go
$brewinstall go
goinstall="go install"
$goinstall golang.org/x/tools/gopls@latest # Language server

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
$brewinstall pyenv pyenv-virtualenv
latest=$(pyenv install --list | sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}')
pyenv install --skip-existing $latest
pyenv global $latest

# Ruby
$brewinstall rbenv ruby-build
latest=$(rbenv install --list 2>/dev/null | sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}')
rbenv install --skip-existing $latest
rbenv global $latest
########################################## End languages

########################################## Start application installations
[[ $debug == "y" ]] && echo "Starting application installations."

# Common tools / replacements
$brewinstall ack awscli direnv ffmpeg gh git jq nvim watch wget

# Neovim & plugin dependencies
$brewinstall fd ripgrep

# Fortune
$brewinstall fortune cowsay
$dotfiles/fortunes/strfile

# GUI apps
$brewinstall --cask discord docker iterm2 stay
########################################## End application installations

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
########################################## End system configuration

########################################## Start one-time boots
open /Applications/iTerm.app
########################################## End one-time boots

########################################## Start manual setup
echo "Some manual steps are still required:"
echo "  - Open iTerm2 prefs → General → Preferences and load from ./preferences/iterm -> Don't Copy -> Select 'Automatically'"
echo "  - Close iTerm2 completely, open Terminal.app and \`git restore\` any changes to ./preferences/iterm/*, then re-open iTerm2"
echo "  - Download Nord color scheme for iTerm2: https://github.com/arcticicestudio/nord-iterm2"
echo "  - Install Magnet: https://apps.apple.com/us/app/magnet/id441258766"
echo "  - Install 1Password: https://apps.apple.com/us/app/1password-7-password-manager/id1333542190"
echo "  - Install Docker: https://docker.com/"
echo ""
echo "That's it!"
########################################## End manual setup
