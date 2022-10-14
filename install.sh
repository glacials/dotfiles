#!/bin/bash
set -euo pipefail
# set -x # uncomment to print all commands as they happen


debug="" # set to y to enable more output
uname=$(uname -s | tr "[:upper:]" "[:lower:]")

apt="sudo apt-get --quiet --quiet --assume-yes"
npm="npm --silent"

# TODO: Refactor so we only need to invoke `brew install` once.

########################################## Start bootstrap
# TODO: See if this section can be removed now that we use chezmoi
sshkey="$HOME/.ssh/id_rsa"
answer="n"

if ! gh auth status 1>/dev/null 2>/dev/null; then
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
fi

cd "$(dirname "$0")"
git submodule init
git submodule update
########################################## End bootstrap

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
brewinstall="$brew install --quiet --force"

# Update path for Homebrew for Linux since we can't source .zshrc yet
export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
export PATH=$HOME/.linuxbrew/bin:$PATH

if [[ $uname == linux* ]]; then
  $apt install -y build-essential # Homebrew asks for this on install
fi
$brewinstall gcc
$brew update --quiet
$brew upgrade --quiet

$brewinstall mas # macOS App Store CLI
masinstall="mas install"
########################################## End package managers

########################################## Start languages
[[ $debug == "y" ]] && echo "Setting up languages."

# Go
$brewinstall go
goinstall="go install"
$goinstall golang.org/x/tools/gopls@latest # Language server
$goinstall github.com/segmentio/golines@latest # gofmt w/ line wrapping

# JavaScript
$brewinstall nodenv npm
$npm install -g bower prettier prettier-plugin-go-template typescript
latest=$(nodenv install --list 2>/dev/null | sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}')
nodenv install --skip-existing $latest
nodenv global $latest

# Override for GitHub Copilot requirements
nodenv install --skip-existing 17.9.1
nodenv global 17.9.1

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
$brewinstall ack awscli chezmoi direnv ffmpeg fzf gh git jq nvim watch visual-studio-code wget

# Neovim & plugin dependencies (TODO: Move these to 'do' hooks in init.vim)
$brewinstall fd ripgrep

# Fortune
$brewinstall fortune cowsay
sh ~/.config/fortune/strfile

# Non-App Store GUI apps (only if not installed; casks don't skip automatically)
brew list 1password     >/dev/null || $brewinstall 1password
brew list discord       >/dev/null || $brewinstall discord
brew list docker        >/dev/null || $brewinstall homebrew/cask/docker
brew list firefox       >/dev/null || $brewinstall firefox
brew list google-chrome >/dev/null || $brewinstall google-chrome
brew list iterm2        >/dev/null || $brewinstall iterm2
brew list kitty         >/dev/null || $brewinstall kitty
brew list stay          >/dev/null || $brewinstall stay

# App Store apps
$masinstall 408981434  # iMovie
$masinstall 409183694  # Keynote
$masinstall 409201541  # Pages
$masinstall 409203825  # Numbers
$masinstall 411643860  # DaisyDisk
$masinstall 430798174  # HazeOver
$masinstall 441258766  # Magnet
$masinstall 497799835  # Xcode
$masinstall 747648890  # Telegram
$masinstall 775737590  # iA Writer
$masinstall 883878097  # Server
$masinstall 920404675  # Monodraw
$masinstall 1085114709 # Parallels Desktop
$masinstall 1233861775 # Acorn
$masinstall 1246969117 # Steam Link
$masinstall 1451544217 # Adobe Lightroom
$masinstall 1475387142 # Tailscale
$masinstall 1478821913 # GoLinks for Safari
$masinstall 1480068668 # Messenger
$masinstall 1480933944 # Vimari
$masinstall 1482454543 # Twitter
$masinstall 1507890049 # Pixeur
$masinstall 1518425043 # Boop
$masinstall 1534275760 # LanguageTool
$masinstall 1569813296 # 1Password for Safari
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

crontab ./cron
########################################## End system configuration

########################################## Start one-time boots
open /Applications/kitty.app
########################################## End one-time boots
