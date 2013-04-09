silent:
	make -s menu

menu:
	echo "Enter one of the following:\n  make links (link dotfiles)\n  make plugins (init/update/add plugins)"

links: Xmodmap bashrc gitconfig irssi vimrc zshrc config vim

plugins:
	./vim-plugin-setup.py

Xmodmap: .Xmodmap
	[ -h ~/.Xmodmap ]   && ln -fs $(shell pwd)/.Xmodmap   ~ || ln -is $(shell pwd)/.Xmodmap   ~

bashrc: .bashrc
	[ -h ~/.bashrc ]    && ln -fs $(shell pwd)/.bashrc    ~ || ln -is $(shell pwd)/.bashrc    ~

gitconfig: .gitconfig
	[ -h ~/.gitconfig ] && ln -fs $(shell pwd)/.gitconfig ~ || ln -is $(shell pwd)/.gitconfig ~

irssi: .irssi
	[ -h ~/.irssi ]     && ln -fs $(shell pwd)/.irssi     ~ || ln -is $(shell pwd)/.irssi     ~

vimrc: .vimrc
	[ -h ~/.vimrc ]     && ln -fs $(shell pwd)/.vimrc     ~ || ln -is $(shell pwd)/.vimrc     ~

zshrc: .zshrc
	[ -h ~/.zshrc ]     && ln -fs $(shell pwd)/.zshrc     ~ || ln -is $(shell pwd)/.zshrc     ~

config: .config
	[ -h ~/.config ]    && ln -fs $(shell pwd)/.config    ~ || ln -is $(shell pwd)/.config    ~

vim: .vim
	[ -h ~/.vim ]       && ln -fs $(shell pwd)/.vim       ~ || ln -is $(shell pwd)/.vim       ~
