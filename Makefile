default: Xdefaults Xmodmap bashrc gitconfig irssi vimrc config vim

plugin:
	./vim-plugin-setup.py

Xmodmap: .Xmodmap
	[ -h ~/.Xmodmap ] && ln -fs $(shell pwd)/.Xmodmap ~ || ln -is $(shell pwd)/.Xmodmap ~

bashrc: .bashrc
	[ -h ~/.bashrc ] && ln -fs $(shell pwd)/.bashrc ~ || ln -is $(shell pwd)/.bashrc ~

gitconfig: .gitconfig
	[ -h ~/.gitconfig ] && ln -fs $(shell pwd)/.gitconfig ~ || ln -is $(shell pwd)/.gitconfig ~

irssi: .irssi
	[ -h ~/.irssi ] && ln -fs $(shell pwd)/.irssi ~ || ln -is $(shell pwd)/.irssi ~

vimrc: .vimrc
	[ -h ~/.vimrc ] && ln -fs $(shell pwd)/.vimrc ~ || ln -is $(shell pwd)/.vimrc ~

config: .config
	[ -h ~/.config ] && ln -frs $(shell pwd)/.config ~ || ln -is $(shell pwd)/.config ~

vim: .vim
	[ -h ~/.vim ] && ln -fs $(shell pwd)/.vim ~ || ln -is $(shell pwd)/.vim ~
