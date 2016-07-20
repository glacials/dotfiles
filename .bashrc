# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# setup prompt
PS1='\[\e[1;32m\][\u@\h:\w]\$\[\e[0m\] '

# enable programmable completion features
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# set vim as the default editor
export EDITOR=vim

# use vim bindings at prompt (esc to enter command mode)
set -o vi

# common aliases
alias df='df -h'
alias du='du -h'
alias grep='grep --color=auto'
alias less='less -Ni'

# quick aliases
alias vi='vim'
alias c='clear'
alias s='screen -x'
alias p='ps -Af | grep'
alias g='git status'
alias add='git add'
alias branch='git branch'
alias checkout='git checkout'
alias commit='git commit'
alias merge='git merge'
alias push='git push'
alias pull='git pull'
alias be='bundle exec'

# misc aliases
alias ag='ag --color-line-number 38\;5\;116 --color-path 38\;5\;75'

# imitate OS X's `open` command
if [[ `uname` != "Darwin" ]]; then
  alias open='xdg-open &>/dev/null'
fi

# the ls family aliases. aren't they cute!
alias ll='ls -l'
alias l='ll'
alias ld='ll -d'
alias la='ll -a'
alias lr='ll -R'
# gnu ls uses --color=auto but os x ls uses -G
if [[ `ls --version` == *"ls (GNU coreutils)"* ]]; then
  alias ls='ls -CFh --color=auto'
else
  alias ls='ls -CFhG'
fi

# ruby things
export PATH="$HOME/.gem/bin:$PATH"
eval "$(rbenv init -)"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

fortune ~/pj/dotfiles/fortunes | cowsay -n

export GOPATH=/Users/ben/go
export PATH=$GOPATH/bin:$PATH
export PATH="/Users/ben/Library/Flex/flex_sdk_4.6/bin":$PATH
export FLEX_HOME="/Users/ben/Library/Flex/flex_sdk_4.6"

source /usr/local/etc/bash_completion.d/git-completion.bash

source ~/.profile
