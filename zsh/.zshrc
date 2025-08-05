uname=$(uname -s | tr "[:upper:]" "[:lower:]")

ZSH_THEME="pygmalion"

# zsh setup.
autoload -Uz zmv
alias zcp="zmv -C"
alias zln="zmv -L"

path+=("$HOME/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin")

if [[ $uname == darwin ]]; then
	path+=("/Applications/Tailscale.app/Contents/MacOS")
fi

# Run history-substituted commands (e.g. `!!`, `!$`) without confirmation.
unsetopt histverify

# General environment variables.
export EDITOR='nvim'
export GPG_TTY=$(tty)

# Aliases.
alias amend='git add -p && git commit --amend --no-edit && git push -f'
alias cat='bat'
alias curl='curl --proto-default https'
alias diff='difft'
alias du='dust'
alias e="$EDITOR"
alias find='fd'
alias g='git status'
alias l='ls -h --color=auto'
alias la='ls -a'
alias lr='eza --long --tree'
alias ls='eza --git --hyperlink --icons --long --octal-permissions --no-user --time-style=relative'
alias noedit='git add -p && git commit --amend --no-edit'
alias rebase='export CURRENT_BRANCH=`git name-rev --name-only HEAD` && git checkout master && git pull && git checkout `echo $CURRENT_BRANCH` && git rebase master'
alias stowall='stow ghostty nvim stow zsh'
alias stowdotfiles='stowgit add -p && stowgit commit && stowgit pull && stowgit push'
alias stowgit='git --git-dir ~/pj/dotfiles'

if [[ $uname == linux* ]]; then
	alias u='sudo apt-get update -qq && sudo apt-get -yqq upgrade && brew update -qq && brew upgrade -qq'
fi

if [[ $uname == darwin ]]; then
	alias u='brew update && brew upgrade --quiet'
fi

alias work='git add -p && git commit -m work && git push'
alias vi=vim
alias vim=nvim
alias vimdiff='vim -d'

export ZSH_FZF_HISTORY_SEARCH_FZF_EXTRA_ARGS='--height 40%'

# Raspbian.
path+=("/sbin")

# Emacs.
path+=("$HOME/.config/emacs/bin")

# Haskell.
path+=("$HOME/.local/bin")
[ -f "/Users/glacials/.ghcup/env" ] && source "/Users/glacials/.ghcup/env" # ghcup-env

# Homebrew.
export HOMEBREW_NO_ENV_HINTS=1
if [[ $uname == linux* ]]; then
	path+=($HOME/.linuxbrew/bin)
	path+=(/home/linuxbrew/.linuxbrew/bin)
else
	path=('/opt/homebrew/bin' $path)
fi

# Go.
export GOPATH=~/go
path+=($GOPATH/bin)

# Node.
path=("$HOME/.nodenv/bin" $path)
nodenv --version 1>/dev/null 2>/dev/null && eval "$(nodenv init -)"

# Ruby.
path+=("$HOME/.rbenv/shims")
rbenv --version 1>/dev/null 2>/dev/null && eval "$(rbenv init -)"

# Snap.
path=('/snap/bin' $path)

# Fun things at shell boot.
if [[ $uname == linux* ]]; then
	# Raspbian doesn't have a small cow.
	fortune --version 1>/dev/null 2>/dev/null && \
	cowsay --version 1>/dev/null 2>/dev/null && \
	fortune ~/.config/fortune | cowsay -n
else
	fortune --version 1>/dev/null 2>/dev/null && \
	cowsay --version 1>/dev/null 2>/dev/null && \
	fortune ~/.config/fortune | cowsay -n -f small
fi

source ~/.profile

# direnv
direnv --version 1>/dev/null 2>/dev/null && eval "$(direnv hook zsh)"

# Prevent zsh from tripping over ?s and &s when curling
alias curl='noglob curl'

# Share history across tabs and sessions
setopt INC_APPEND_HISTORY       # Immediately append to the history file
setopt SHARE_HISTORY            # Share command history data
setopt HIST_IGNORE_DUPS         # Don't record duplicate commands
setopt HIST_FIND_NO_DUPS        # Prevent showing dups in history search
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks
