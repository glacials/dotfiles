# oh-my-zsh setup
export ZSH=/Users/glacials/.oh-my-zsh
ZSH_THEME="pygmalion"
DISABLE_AUTO_UPDATE="true"
plugins=(bundler brew common-aliases dircycle encode64 gem osx rails ruby vi-mode zeus)
source $ZSH/oh-my-zsh.sh

# run history-substituted commands (e.g. containing `!!` or `!$`) without confirmation
unsetopt histverify

alias vi=vim
alias vim=nvim
alias g=git status
alias rebase='export CURRENT_BRANCH=`git name-rev --name-only HEAD` && git checkout master && git pull && git checkout `echo $CURRENT_BRANCH` && git rebase master'
alias lock='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine'
unalias rm

# general env vars
export EDITOR=nvim
export SHELL=zsh
export GPG_TTY=$(tty)

# ruby
export PATH=~/.rbenv/shims:$PATH
eval "$(rbenv init -)"

# go
export GOPATH=~/go
export PATH=$GOPATH/bin:$PATH

# gpg (from https://gist.github.com/bmhatfield/cc21ec0a3a2df963bffa3c1f884b676b)
GPG_TTY=$(tty)
export GPG_TTY
if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
else
    eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
fi

# fun things at shell boot
fortune ~/pj/dotfiles/fortunes | cowsay -n
source ~/.profile
