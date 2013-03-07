Setting up
-----------------------
After cloning this repo to the location of your choosing, `cd` to it and

    make links

to generate symlinks from your home directory to these files.

Submodules
--------------
I use Git submodules for all my Vim plugins with help from [pathogen][1], so to
manage plugins just run

    make plugins

You'll want to use option 1 the first time you pull in order to grab all
submodules. Use option 2 to update once in a while and option 3 to add a new
plugin from GitHub.

[1]: http://github.com/tpope/vim-pathogen/ "tpope/vim-pathogen"
