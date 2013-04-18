#!/usr/bin/env python3

import subprocess
import os
import sys

if os.path.exists(".vim/bundle/YouCompleteMe"):
  print(
  """vim-plugin-setup: What would you like to do?
    1. Init plugins
    2. Pull each plugin
    3. Add a plugin from GitHub
    4. (Re)compile ycm_core (for YouCompleteMe)
    q. Quit"""
  )
else:
  print(
  """vim-plugin-setup: What would you like to do?
    1. Init plugins
    2. Pull each plugin
    3. Add a plugin from GitHub
    q. Quit"""
  )
cin = input("Enter an option: ")

# Quit
if cin is "q":
  sys.exit()

# Init plugins
if cin is "1":
  subprocess.call(["git", "submodule", "init"])
  subprocess.call(["git", "submodule", "update"])

# Pull each plugin
if cin is "2":
  subprocess.call(["git", "submodule", "foreach", "git", "pull", "origin", "master"])

# Add a plugin from GitHub
if cin is "3":
  if not os.path.exists(".vim"):
    print("To add a plugin, you must run this script from the directory containing your .vim folder.")
    print("You are currently in", os.getcwd())
    sys.exit()
  else:
    print("Enter GitHub plugin path in the format Username/Reponame.")
    cin = input("user/repo: ")
    repository = cin.partition("/")
    user = repository[0]
    repo = repository[2]
    url = "git@github.com:" + user + "/" + repo
    dir = ".vim/bundle/" + repo
    print("Grabbing", repo, "from", user)
    subprocess.call(["git", "submodule", "add", "-f", url, dir])

# (Re)compile ycm_core (for YouCompleteMe)
if cin is "4":
  os.chdir(".vim/bundle/YouCompleteMe")
  subprocess.call(["./install.sh"])
