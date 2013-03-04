setting up the dotfiles
-----------------------
After cloning this repo to the location of your choosing, `cd` to it and execute
`linkdotfiles` to generate symlinks from your home directory to these files.

git submodules
--------------
I always forget how to do this and end up messing up my entire repo, so I've
made a Makefile and a script to do the heavy lifting.

After pulling this repo for the first time,

	make links
	make plugins

and use option 1. You're done!

To upgrade all submodules under this repo,

	make plugins

and use option 2. To add a new submodule, use option 3.

Shoutouts to [pathogen][1] for taking care of the Vim plugin legwork.

[1]: http://github.com/tpope/vim-pathogen/ "tpope/vim-pathogen"
