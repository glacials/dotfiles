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

# setup prompt
autoload -U promptinit
promptinit
autoload -U colors && colors
PROMPT=%{$fg_bold[green]%}[%n@%m:%~]$%{$reset_color%}\ 

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

# the ls family aliases. aren't they cute!
alias ls='ls -CFh --color=auto'
alias ll='ls -l'
alias l='ll'
alias ld='ll -d'
alias la='ll -a'
alias lr='ll -R'

# ruby things
export GEM_HOME=~/.gem
export GEM_PATH=~/.gem

fortune | cowsay -n
