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

# colorize prompt
force_color_prompt=yes

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# various command overrides for colors, etc.
if [ -x /usr/bin/dircolors ]; then

  # colors
  eval "`dircolors -b`"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'

  # human-readable stuff
  alias ls='ls -h'
  alias du='du -h'

fi

# enable programmable completion features
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# set vim as the default editor
export EDITOR=vim

# common aliases
alias vi='vim'
alias c='clear'
alias s='screen -x'
alias p='ps -Af | grep'
alias g='git status'
alias u='sudo aptitude update && sudo aptitude safe-upgrade -y'

# the ls family aliases. aren't they cute!
alias ls='ls -CF --color=auto'
alias ll='ls -lh'
alias l='ll'
alias lla='ls -al'
alias la='lla'

# include j
export JPY=~/.helpers/j2/j.py # tells j.sh where the python script is
. ~/.helpers/j2/j.sh          # provides the j() function

