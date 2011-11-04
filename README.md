
pseudo-cloning this repo
------------------------
Since this repo is meant *not* to be exclusive under its own directory (`~`),
we cannot just do a `git clone`, so we need to

	cd
	git init
	git remote add origin git@github.com:skoh-fley/dotfiles
	git pull origin master

and also

	git submodule update --init
	
or see below.

git submodules
--------------
I always forget how to do this and end up messing up my entire repo, so here's
a friendly but stern reminder to myself.

After pulling this repo for the first time,

	git submodule update --init

(which is the same thing as

	git submodule init
	git submodule update

), which grabs current versions of all this repo's submodules. You're done!

To upgrade one submodule, `cd` to it and just

	git pull origin master

or, to upgrade all submodules under this repo,

	git submodule foreach git pull origin master

and you're done. To add a new submodule that is, for example, a vim plugin on
GitHub, just

	git submodule add -f http://github.com/<user>/<repo>.git .vim/bundle/<plugin>

and [pathogen][1] should take care of the rest.

[1]: http://github.com/tpope/vim-pathogen/ "tpope/vim-pathogen"
