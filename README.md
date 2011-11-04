
pseudo-cloning this repo
------------------------
Since this repo is meant *not* to be exclusive under its own directory (`~`),
we cannot just do a `git clone`, so we need to

	cd
	git init
	git remote add origin git@github.com:skoh-fley/dotfiles
	git pull origin master

And don't forget to also

	git submodule update --init
	
Or see below.

git submodules
--------------
I always forget how to do this and end up messing up my entire repo, so here's
a friendly but stern reminder to myself.

After pulling this repo,

	git submodule update --init

Which is the same thing as

	git submodule init
	git submodule update

Which grabs current versions of all this repo's submodules. You're done!

To upgrade one submodule, `cd` to it and just

	git pull origin master

Or, to upgrade all submodules under this repo, run

	git submodule foreach git pull origin master

To add a new submodule that is, for example, a vim plugin on GitHub, run

	git submodule add -f http://github.com/<user>/<repo>.git .vim/bundle/<plugin>
