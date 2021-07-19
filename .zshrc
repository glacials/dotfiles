# oh-my-zsh setup
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="pygmalion"
DISABLE_AUTO_UPDATE="true"
plugins=(bundler brew common-aliases dircycle encode64 gem osx rails ruby vi-mode zeus zsh-iterm-touchbar)
source $ZSH/oh-my-zsh.sh

path+=("/usr/local/opt/node@6/bin")
path+=("$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin")
path+=("/home/linuxbrew/.linuxbrew/bin")

# run history-substituted commands (e.g. containing `!!` or `!$`) without confirmation
unsetopt histverify

alias vi=vim
alias vimdiff='vim -d'
alias gs='git status'
alias rebase='export CURRENT_BRANCH=`git name-rev --name-only HEAD` && git checkout master && git pull && git checkout `echo $CURRENT_BRANCH` && git rebase master'
alias lock='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine'

# general env vars
export EDITOR=vim
export GPG_TTY=$(tty)
export AWS_DEFAULT_REGION=us-east-1

# Python
export PYENV_ROOT="$HOME/.pyenv"
path+=("$PYENV_ROOT/bin:$PATH")
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Ruby
path+=("~/.rbenv/shims:$PATH")
eval "$(rbenv init -)"

# Go
export GOPATH=~/go
path+=("$GOPATH/bin:$PATH")

# fun things at shell boot
fortune ~/pj/dotfiles/fortunes | cowsay -n
source ~/.profile

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# direnv
eval "$(direnv hook zsh)"
