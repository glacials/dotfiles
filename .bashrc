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
alias commit='git commit'
alias push='git push'
alias pull='git pull'

# imitate OS X's `open` command
alias open='xdg-open &>/dev/null'

# the ls family aliases. aren't they cute!
if [[ `uname` == "Darwin" ]]; then
  alias ls='ls -CFhG'
else
  alias ls='ls -CFh --color=auto'
fi
alias ll='ls -l'
alias l='ll'
alias ld='ll -d'
alias la='ll -a'
alias lr='ll -R'

# ruby things
export GEM_HOME=~/.gem
export GEM_PATH=~/.gem

fortune ~/dotfiles/fortunes | cowsay -n
