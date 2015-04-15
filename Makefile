pwd = $(shell pwd)

all:
	$(MAKE) links
	$(MAKE) init
	$(MAKE) update
	$(MAKE) pull
	$(MAKE) command-t
	$(MAKE) fortune

links: amethyst bashrc gitconfig gitignore_global irssi vimrc zshrc vim

init:
	./vim-plugin-setup.py init

update:
	./vim-plugin-setup.py update

pull:
	./vim-plugin-setup.py pull

command-t:
	./vim-plugin-setup.py command-t

fortune:
	ls ./fortunes || git clone git@github.com:glacials/fortunes ./fortunes
	cd ./fortunes && ./strfile

add:
	./vim-plugin-setup.py add

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

vim:
	[ -h ~/.vim ]              && ln -fs $(pwd)/.vim              ~ || ln -is $(pwd)/.vim              ~
