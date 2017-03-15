pwd = $(shell pwd)

# if you're setting up a machine for the first time and not just re-running make on an existing one, you should do the
# following manual steps after running make:
#
# - visit https://gist.github.com/bmhatfield/cc21ec0a3a2df963bffa3c1f884b676b and follow steps 2 onward

all:
	$(MAKE) osx-setup # for new OS X machines. remove if you're on linux, and resolve missing dependencies en route.
	$(MAKE) links
	$(MAKE) init
	$(MAKE) update
	$(MAKE) pull
	$(MAKE) fortune
	$(MAKE) profile
	$(MAKE) replace_session
	$(MAKE) npm

osx-setup:
	$(MAKE) dependencies
	$(MAKE) programs
	$(MAKE) ruby
	$(MAKE) zsh

dependencies:
	brew install python3 pinentry-mac gpg

programs:
	brew install ag vim ssh-copy-id neovim/neovim/neovim terraform
	brew cask install scroll-reverser

configure:
	git config --global user.name glacials
	git config --global user.email qhiiyr@gmail.com

gpg-sign-commits:
	brew install gnupg gpg-agent pinentry-mac
	git config --global commit.gpgsign true

zsh:
	chsh -s /bin/zsh `whoami`

ruby:
	brew install rbenv ruby-build

links: amethyst bashrc gitconfig gitignore_global irssi nvim oh-my-zsh vim vimrc zshrc

init:
	mkdir -p ~/.config
	./vim-plugin-setup.py init

update:
	./vim-plugin-setup.py update

pull:
	./vim-plugin-setup.py pull

fortune:
	brew install fortune cowsay
	./fortunes/strfile

profile:
	touch ~/.profile

replace_session:
	zsh

npm:
	brew install npm
	npm install -g typescript

add:
	./vim-plugin-setup.py add

amethyst:
	[ -h ~/.amethyst ]             && ln -fs $(pwd)/.amethyst             ~         || ln -is $(pwd)/.amethyst             ~

bashrc:
	[ -h ~/.bashrc ]               && ln -fs $(pwd)/.bashrc               ~         || ln -is $(pwd)/.bashrc               ~

gitconfig:
	[ -h ~/.gitconfig ]            && ln -fs $(pwd)/.gitconfig            ~         || ln -is $(pwd)/.gitconfig            ~

gitignore_global:
	[ -h ~/.gitignore_global ]     && ln -fs $(pwd)/.gitignore_global     ~         || ln -is $(pwd)/.gitignore_global     ~

gpg-agent:
	[ -h ~/.gnupg/gpg-agent.conf ] && ln -fs $(pwd)/.gnupg/gpg-agent.conf ~/.gnupg  || ln -is $(pwd)/.gnupg/gpg-agent.conf ~/.gnupg

irssi:
	[ -h ~/.irssi ]                && ln -fs $(pwd)/.irssi                ~         || ln -is $(pwd)/.irssi                ~

nvim:
	[ -h ~/.config/nvim ]          && ln -fs $(pwd)/.config/nvim          ~/.config || ln -is $(pwd)/.config/nvim          ~/.config

oh-my-zsh:
	[ -h ~/.oh-my-zsh ]            && ln -fs $(pwd)/.oh-my-zsh            ~         || ln -is $(pwd)/.oh-my-zsh            ~

vim:
	[ -h ~/.vim ]                  && ln -fs $(pwd)/.vim                  ~         || ln -is $(pwd)/.vim                  ~

vimrc:
	[ -h ~/.vimrc ]                && ln -fs $(pwd)/.vimrc                ~         || ln -is $(pwd)/.vimrc                ~

zshrc:
	[ -h ~/.zshrc ]                && ln -fs $(pwd)/.zshrc                ~         || ln -is $(pwd)/.zshrc                ~
