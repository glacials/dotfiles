pwd = $(shell pwd)

all:
	$(MAKE) links
	$(MAKE) init
	$(MAKE) pull
	$(MAKE) fortune

links: Xmodmap amethyst bashrc gitconfig gitignore_global irssi vimrc zshrc vim

init:
	./vim-plugin-setup.py init

pull:
	./vim-plugin-setup.py pull

fortune:
	ls ~/dotfiles/fortunes &>/dev/null || git clone git@github.com:skoh-fley/fortunes ~/dotfiles/fortunes
	cd ~/dotfiles/fortunes && ./strfile

add:
	./vim-plugin-setup.py add

ycm_core:
	./vim-plugin-setup.py ycm_core

Xmodmap: .Xmodmap
	[ -h ~/.Xmodmap ]          && ln -fs $(pwd)/.Xmodmap          ~ || ln -is $(pwd)/.Xmodmap          ~

amethyst: .amethyst
	[ -h ~/.amethyst ]         && ln -fs $(pwd)/.amethyst         ~ || ln -is $(pwd)/.amethyst         ~

bashrc: .bashrc
	[ -h ~/.bashrc ]           && ln -fs $(pwd)/.bashrc           ~ || ln -is $(pwd)/.bashrc           ~

gitconfig: .gitconfig
	[ -h ~/.gitconfig ]        && ln -fs $(pwd)/.gitconfig        ~ || ln -is $(pwd)/.gitconfig        ~

gitignore_global: .gitignore_global
	[ -h ~/.gitignore_global ] && ln -fs $(pwd)/.gitignore_global ~ || ln -is $(pwd)/.gitignore_global ~

irssi: .irssi
	[ -h ~/.irssi ]            && ln -fs $(pwd)/.irssi            ~ || ln -is $(pwd)/.irssi            ~

vimrc: .vimrc
	[ -h ~/.vimrc ]            && ln -fs $(pwd)/.vimrc            ~ || ln -is $(pwd)/.vimrc            ~

zshrc: .zshrc
	[ -h ~/.zshrc ]            && ln -fs $(pwd)/.zshrc            ~ || ln -is $(pwd)/.zshrc            ~

#config:
#	[ -h ~/.config ]           && ln -fs $(pwd)/.config           ~ || ln -is $(pwd)/.config           ~

vim:
	[ -h ~/.vim ]              && ln -fs $(pwd)/.vim              ~ || ln -is $(pwd)/.vim              ~
