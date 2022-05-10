# dotfiles

This repository fully bootstraps a new machine to be configured how I like it. It sets
up dotfiles, installs programs and development tools I use, and does several
miscellaneous things I've automated out of my new machine setup process.

It will work for anyone, but it is very opinionated and custom built for my own needs.

## Installation

This repository does not need to be cloned; it clones itself. You do not need to set up
an SSH key first; it handles that for you.

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/glacials/dotfiles/HEAD/install.sh)"
```

This command is idempotent; it is safe to run multiple times.

## Caveats

There are a few manual steps I haven't automated. The script will ask you to perform
them at the end of the process, in the style of [do-nothing scripting][donothing].

This project aims to be compatible with macOS and Linux; however it gets far more
real-world testing on macOS, so Linux support may trip over a thing or two.

[donothing]: https://blog.danslimmon.com/2019/07/15/do-nothing-scripting-the-key-to-gradual-automation/
