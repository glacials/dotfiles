# oh-my-zsh setup
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="pygmalion"
plugins=(bundler brew common-aliases dircycle encode64 gem osx rails ruby vi-mode zeus zsh-iterm-touchbar)
source $ZSH/oh-my-zsh.sh

path+=("$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin")

# run history-substituted commands (e.g. containing `!!` or `!$`) without confirmation
unsetopt histverify

alias work='git add -p && git commit -m work && git push'
alias amend='git add -p && git commit --amend --no-edit && git push -f'
alias g='git status'
alias rebase='export CURRENT_BRANCH=`git name-rev --name-only HEAD` && git checkout master && git pull && git checkout `echo $CURRENT_BRANCH` && git rebase master'

if [[ $(uname -s) == LINUX* ]]; then
  alias u='sudo apt-get update -qq && sudo apt-get -yqq upgrade && brew update -qq && brew upgrade -qq'
fi

if [[ $(uname -s) == Darwin ]]; then
  alias u='brew update && brew upgrade --quiet'
fi

alias vi=vim
alias vim=nvim
alias vimdiff='vim -d'

# General env vars
export AWS_DEFAULT_REGION=us-east-1
export EDITOR=vim
export GPG_TTY=$(tty)

# Homebrew for Linux
path+=($HOME/.linuxbrew/bin)
path+=(/home/linuxbrew/.linuxbrew/bin)

# Go
export GOPATH=~/go
path+=($GOPATH/bin)

# Python
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# Ruby
path+=("$HOME/.rbenv/shims")
eval "$(rbenv init -)"

# fun things at shell boot
fortune ~/pj/dotfiles/fortunes | cowsay -n
source ~/.profile

# direnv
eval "$(direnv hook zsh)"
