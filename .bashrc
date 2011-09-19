# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# attach to our default screen
#if [ -z "$STY" ]; then
#  exec byobu
#fi

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

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable programmable completion features
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# set vim as the default editor
export EDITOR=vim

# common aliases
alias du='du -h'
alias grep='grep --color=auto'

# quick aliases
alias vi='vim'
alias c='clear'
alias s='screen -x'
alias p='ps -Af | grep'
alias g='git status'
alias u='sudo aptitude update && sudo aptitude safe-upgrade -y'

# the ls family aliases. aren't they cute!
alias ls='ls -CFh --color=auto'
alias ll='ls -l'
alias l='ll'
alias la='ll -a'
alias lr='ll -R'

# include j
export JPY=~/.helpers/j2/j.py # tells j.sh where the python script is
. ~/.helpers/j2/j.sh          # provides the j() function

