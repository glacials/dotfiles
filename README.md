# dotfiles

> [!NOTE]
> I'm currently migrating this repository from
> [Chezmoi](https://www.chezmoi.io/)-based
> to
> [GNU Stow](https://www.gnu.org/software/stow/).
> The instructions below may be temporarily inconsistent with the new setup.
>
> I've used Chezmoi for this repo for three years, which has been a sufficient trial.
> It's a powerful tool but I found myself learning and/or fighting with its patterns
> no less than I had with Bash and Make before switching.
>
> Its `run_onchange_*` and related scripts encouraged me to make the whole repo a one-button machine setup/upgrade,
> but I haven't been setting up machines frequently enough to get any pay off.
> And when I do set up machines it's usually an ephemeral remote devbox,
> meaning I don't need 90% of my dotfiles and setup scripts (e.g. App Store, casks, `rbenv`, etc.).
>
> This has made Stow, which is simpler and focused on piecemeal installation,
> feel like a better fit.

This repository holds my configuration files for macOS and Linux. bootstraps a new machine to be configured how I like it.
It sets up dotfiles, installs programs and development tools I use, and does
several miscellaneous things I've automated out of my new machine setup process.

It will work for anyone, but it is very opinionated and custom built for my own
needs.

## Installation

### Prerequisites

If coming from a new machine, you only need:

- [Homebrew](https://brew.sh/)
- [GNU Stow](https://www.gnu.org/software/stow/)
- Your SSH key in GitHub

#### Copy-paste Install Of Prerequisites

This will install Homebrew and GNU Stow:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
/opt/homebrew/bin/brew install stow
```

This will generate an SSH key and add it to your GitHub account:

```sh
ssh-keygen -N ""
gh auth login --git-protocol ssh --hostname github.com --web
```

### Clone & Stow

```sh
mkdir -p ~/pj
git clone git@github.com:glacials/dotfiles ~/pj/dotfiles
cd ~/pj/dotfiles
stow nvim stow zsh
```

Start a new shell.
After this step,
future invocations of `stow` will have access to the global `.stowrc`,
and therefore will not need to be run from inside `~/pj/dotfiles`.

### Troubleshooting

If the first run fails for some reason and later runs refuse to clone, try `rm
~/.gitconfig`, as it forces `git@github.com` over `https://github.com`, which will
fail if the installation didn't yet set up SSH keys for you.

### Updates

To make updates to dotfiles, use `chezmoi edit --apply $FILE`. Updates will be
automatically committed and pushed.

## Caveats

This project aims to be compatible with macOS and Linux; however it gets far
more real-world testing on macOS, so Linux support may trip over a thing or two.

## History

This started as a series of dotfiles, then a Makefile to link them, then an
install script to manage installation of common tools and differences between
operating systems. Today, dotfile management is outsourced to
[`chezmoi`](https://github.com/twpayne/chezmoi).
