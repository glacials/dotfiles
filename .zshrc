# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="blinks"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git github osx battery brew)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin

# Don't confirm things like !! and !$ before executing
setopt no_hist_verify

# set default programs
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
alias ls='ls -CFhG'
alias ll='ls -l'
alias l='ll'
alias la='ll -a'
alias lr='ll -R'
