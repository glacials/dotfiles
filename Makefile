pwd = $(shell pwd)

all:
	$(MAKE) links
	$(MAKE) init
	$(MAKE) fortune

init:
	./vim-plugin-setup.py init

pull:
	./vim-plugin-setup.py pull

add:
	./vim-plugin-setup.py add

ycm_core:
	./vim-plugin-setup.py ycm_core

links: Xmodmap bashrc gitconfig irssi vimrc zshrc vim

Xmodmap: .Xmodmap
	[ -h ~/.Xmodmap ]   && ln -fs $(pwd)/.Xmodmap   ~ || ln -is $(pwd)/.Xmodmap   ~

bashrc: .bashrc
	[ -h ~/.bashrc ]    && ln -fs $(pwd)/.bashrc    ~ || ln -is $(pwd)/.bashrc    ~

gitconfig: .gitconfig
	[ -h ~/.gitconfig ] && ln -fs $(pwd)/.gitconfig ~ || ln -is $(pwd)/.gitconfig ~

irssi: .irssi
	[ -h ~/.irssi ]     && ln -fs $(pwd)/.irssi     ~ || ln -is $(pwd)/.irssi     ~

vimrc: .vimrc
	[ -h ~/.vimrc ]     && ln -fs $(pwd)/.vimrc     ~ || ln -is $(pwd)/.vimrc     ~

zshrc: .zshrc
	[ -h ~/.zshrc ]     && ln -fs $(pwd)/.zshrc     ~ || ln -is $(pwd)/.zshrc     ~

#config:
	#[ -h ~/.config ]    && ln -fs $(pwd)/.config    ~ || ln -is $(pwd)/.config    ~

vim:
	[ -h ~/.vim ]       && ln -fs $(pwd)/.vim       ~ || ln -is $(pwd)/.vim       ~

fortune:
	ls ~/dotfiles/fortunes &>/dev/null || git clone git@github.com:skoh-fley/fortunes ~/dotfiles/fortunes
	cd ~/dotfiles/fortunes && ./strfile
