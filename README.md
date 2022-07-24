# dotfiles

This repository fully bootstraps a new machine to be configured how I like it.
It sets up dotfiles, installs programs and development tools I use, and does
several miscellaneous things I've automated out of my new machine setup process.

It will work for anyone, but it is very opinionated and custom built for my own
needs.

## Installation

This repository does not need to be cloned and you do not need to set up an SSH
key first. Just run:

```sh
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply glacials && $(chezmoi source-path)/install.sh
```

### Troubleshooting

If the first run fails for some reason and later runs refuse to clone, try `rm
~/.gitconfig`, as it forces git@github.com over https://github.com, which will
fail if the installation didn't yet set up SSH keys for you.

### Updates

To make updates to dotfiles, use `chezmoi edit $FILE`. Updates will be
automatically committed and pushed.

## Caveats

This project aims to be compatible with macOS and Linux; however it gets far
more real-world testing on macOS, so Linux support may trip over a thing or two.

## History

This started as a series of dotfiles, then a Makefile to link them, then an
install script to manage installation of common tools and differences between
operating systems. Today, dotfile management is outsourced to
[`chezmoi`](https://github.com/twpayne/chezmoi).
