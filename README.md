## Installation

    make

Generates all the symlinks it can (without overwriting anything), then initializes and pulls submodules.  Alternatively,
`make links` then `make init`.

## Update Vim plugins

    make pull

## Add a new Vim plugin from GitHub
```sh
./vim-plugin-setup.py add <user/repo>
```

## Install Other Software
Some software I consider vital isn't installed automatically:
- [Stay][1] (requires license key emailed to you)
- [Magnet][2]
- [1Password][3]
- [Docker][4]

[1]: https://cordlessdog.com/stay/
[2]: https://itunes.apple.com/us/app/magnet/id441258766?mt=12
[3]: https://1password.com/
[4]: https://docker.com/
