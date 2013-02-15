setting up the dotfiles
-----------------------
After cloning this repo to the location of your choosing, `cd` to it and execute
`linkdotfiles` to generate symlinks from your home directory to these files.

git submodules
--------------
I always forget how to do this and end up messing up my entire repo, so here's
a friendly but stern reminder to myself.

After pulling this repo for the first time,

	git submodule update --init

or if you like 

	git submodule init
	git submodule update

which both identically grab current versions of all this repo's submodules.
You're done!

To upgrade one submodule, `cd` to it and just

	git pull origin master

or, to upgrade all submodules under this repo,

	git submodule foreach git pull origin master

and you're done. To add a new submodule that is, for example, a vim plugin on
GitHub, just

	git submodule add -f http://github.com/<user>/<repo>.git .vim/bundle/<plugin>

and [pathogen][1] should take care of the rest.

[1]: http://github.com/tpope/vim-pathogen/ "tpope/vim-pathogen"
