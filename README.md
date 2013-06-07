## Installation

    make

will generate all the symlinks it can (without overwriting anything),
then initialize and pull all submodules. Alternatively, `make links`
then `make init`.

## Updating Vim plugins

    make pull

### YouCompleteMe
If you get an error about YouCompleteMe's ycm_core whenever you start up
vim, run

    make ycm_core
    
to recompile it. This happens usually when YouCompleteMe gets updated, or
the first time you use it.
