#!/bin/bash
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

if [[ $uname == darwin ]]; then
    $brewinstall mas # macOS App Store CLI
    masinstall="mas install"
fi
########################################## End package managers

########################################## Start languages
[[ $debug == "y" ]] && echo "Setting up languages."

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
    # Runtime dependencies of pyenv (https://github.com/pyenv/pyenv/wiki#suggested-build-environment)
    $apt install make build-essential libssl-dev zlib1g-dev \
         libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
         libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
    export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/openssl@3/lib"
    export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/openssl@3/include"
fi
$npm install -g pyright # Language server
$brewinstall pyenv pyenv-virtualenv
latest=$(pyenv install --list | sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}')
pyenv install --skip-existing $latest
pyenv global $latest

# Ruby
$brewinstall rbenv ruby-build solargraph
latest=$(rbenv install --list 2>/dev/null | sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}')
rbenv install --skip-existing $latest
rbenv global $latest
########################################## End languages

########################################## Start application installations
[[ $debug == "y" ]] && echo "Starting application installations."

# Common tools / replacements
$brewinstall ack awscli chezmoi difftastic direnv ffmpeg fzf gh git jq nvim starship syncthing tmux watch visual-studio-code wget youtube-dl

# Neovim & plugin dependencies (TODO: Move these to 'do' hooks in init.vim)
$brewinstall fd ripgrep

# Emacs
$brewinstall railwaycat/emacsmacport/emacs-mac

# Fortune
$brewinstall fortune cowsay
sh ~/.config/fortune/strfile

# Services
brew services start syncthing

# Casks (casks still install even if already installed, so we skip here if so)
brew list 1password            >/dev/null || $brewinstall 1password
brew list discord              >/dev/null || $brewinstall discord
brew list docker               >/dev/null || $brewinstall homebrew/cask/docker
brew list firefox              >/dev/null || $brewinstall firefox
brew list font-hack-nerd-font  >/dev/null || $brewinstall homebrew/cask-fonts/font-hack-nerd-font
brew list font-jetbrains-mono  >/dev/null || $brewinstall homebrew/cask-fonts/font-jetbrains-mono
brew list font-source-code-pro >/dev/null || $brewinstall homebrew/cask-fonts/font-source-code-pro
brew list google-chrome        >/dev/null || $brewinstall google-chrome
brew list iterm2               >/dev/null || $brewinstall iterm2
brew list kitty                >/dev/null || $brewinstall kitty
brew list launchcontrol        >/dev/null || $brewinstall launchcontrol
brew list stay                 >/dev/null || $brewinstall stay
brew list vlc                  >/dev/null || $brewinstall vlc

# App Store apps
if [[ $uname == darwin ]]; then
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
    $masinstall 1046095491 # Freeze - for Amazon Glacier
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
fi
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

# Point ~/icloud to iCloud Drive
if [ ! -L ~/icloud ]; then
    ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs ~/icloud
fi

# Cron et al.
crontab ./cron
ln -s $(chezmoi source-path)/LaunchAgents/* ~/Library/LaunchAgents
########################################## End system configuration

########################################## Start one-time boots
open /Applications/kitty.app
########################################## End one-time boots
