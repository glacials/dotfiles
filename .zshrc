# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/ben/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd nomatch notify
unsetopt beep extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
# shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# shopt -s checkwinsize

# setup prompt
autoload -U promptinit
promptinit
autoload -U colors && colors
PROMPT=%{$fg_bold[green]%}[%n@%m:%~]$%{$reset_color%}\ 

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
alias ga='git add'
alias gc='git commit'
alias gp='git push origin'

# the ls family aliases. aren't they cute!
alias ls='ls -CFh --color=auto'
alias ll='ls -l'
alias l='ll'
alias la='ll -a'
alias lr='ll -R'

# ruby things
export GEM_HOME=~/.gem
export GEM_PATH=~/.gem
