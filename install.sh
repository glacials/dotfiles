#!/bin/bash

if ! test -f $HOME/.ssh/id_rsa; then
	ssh-keygen -f "$HOME/.ssh/id_rsa" -N ""
fi
