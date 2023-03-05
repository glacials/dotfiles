#!/bin/bash

uname=$(uname -s | tr "[:upper:]" "[:lower:]")

brew="brew"
brewinstall="$brew install --quiet --force"

if ! $brew --version 1>/dev/null 2>/dev/null; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ $uname == linux ]]; then
        (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/glacials/.profile

        # Update path for Homebrew for Linux
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

        if [[ -d "/home/linuxbrew" ]]; then
            brew="/home/linuxbrew/.linuxbrew/bin/brew"
        else
            brew="$HOME/.linuxbrew/bin/brew"
        fi
        brewinstall="$brew install --quiet --force"

        # Homebrew asks for these on install
        $brewinstall gcc
        if [[ $pkgmgr == apt ]]; then
            $apt install -y build-essential
        else
            $yum groupinstall 'Development Tools'
        fi
    fi
fi
