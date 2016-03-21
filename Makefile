pwd = $(shell pwd)

all:
	$(MAKE) osx-setup # for new OS X machines. remove if you're on linux, and resolve missing dependencies en route.
	$(MAKE) links
	$(MAKE) init
	$(MAKE) update
	$(MAKE) pull
	$(MAKE) fortune
	$(MAKE) profile
	$(MAKE) replace_session

osx-setup:
	$(MAKE) dependencies
	$(MAKE) ruby
	$(MAKE) zsh

dependencies:
	brew install python3 fortune

zsh:
	chsh -s /bin/zsh `whoami`

ruby:
	brew install rbenv ruby-build

links: amethyst bashrc gitconfig gitignore_global irssi oh-my-zsh vim vimrc zshrc

init:
	./vim-plugin-setup.py init

update:
	./vim-plugin-setup.py update

pull:
	./vim-plugin-setup.py pull

fortune:
	ls ./fortunes || git clone git@github.com:glacials/fortunes ./fortunes
	cd ./fortunes && ./strfile

profile:
	touch ~/.profile

replace_session:
	zsh

add:
	./vim-plugin-setup.py add

amethyst:
	[ -h ~/.amethyst ]         && ln -fs $(pwd)/.amethyst         ~ || ln -is $(pwd)/.amethyst         ~

bashrc:
	[ -h ~/.bashrc ]           && ln -fs $(pwd)/.bashrc           ~ || ln -is $(pwd)/.bashrc           ~

gitconfig:
	[ -h ~/.gitconfig ]        && ln -fs $(pwd)/.gitconfig        ~ || ln -is $(pwd)/.gitconfig        ~

gitignore_global:
	[ -h ~/.gitignore_global ] && ln -fs $(pwd)/.gitignore_global ~ || ln -is $(pwd)/.gitignore_global ~

irssi:
	[ -h ~/.irssi ]            && ln -fs $(pwd)/.irssi            ~ || ln -is $(pwd)/.irssi            ~

oh-my-zsh:
	[ -h ~/.oh-my-zsh ]        && ln -fs $(pwd)/.oh-my-zsh        ~ || ln -is $(pwd)/.oh-my-zsh        ~

vim:
	[ -h ~/.vim ]              && ln -fs $(pwd)/.vim              ~ || ln -is $(pwd)/.vim              ~

vimrc:
	[ -h ~/.vimrc ]            && ln -fs $(pwd)/.vimrc            ~ || ln -is $(pwd)/.vimrc            ~

zshrc:
	[ -h ~/.zshrc ]            && ln -fs $(pwd)/.zshrc            ~ || ln -is $(pwd)/.zshrc            ~
