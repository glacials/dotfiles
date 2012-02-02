# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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
PS1='\[\e[1;32m\][\u@\H:\w]\$\[\e[0m\] '

# enable programmable completion features
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# unbind ^q and ^s (for rtorrent)
stty stop undef
stty start undef

# set vim as the default editor
export EDITOR=vim
export VMAIL_BROWSER=elinks

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
alias ls='ls -CFh --color'
alias ll='ls -l'
alias l='ll'
alias la='ll -a'
alias lr='ll -R'

# include j
export JPY=~/.helpers/j2/j.py # tells j.sh where the python script is
. ~/.helpers/j2/j.sh          # provides the j() function

