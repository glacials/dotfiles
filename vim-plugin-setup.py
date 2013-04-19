#!/usr/bin/env python3

import subprocess
import os
import sys

cin = None

if len(sys.argv) is 1 or (sys.argv[1] == "add" and len(sys.argv) < 3):
  if os.path.exists(".vim/bundle/YouCompleteMe"):
    print("Usage: " + sys.argv[0] + " <command>")
    print("")
    print("Commands are:")
    print("    init              Initialize all Vim plugins")
    print("    pull              Pull all Vim plugins")
    print("    add <user/repo>   Add a Vim plugin from GitHub repository at user/repo")
    print("    ycm_core          Recompile ycm_core for YouCompleteMe")
    sys.exit()

# Init plugins
if sys.argv[1] == "init":
  subprocess.call(["git", "submodule", "init"])
  subprocess.call(["git", "submodule", "update"])

# Pull each plugin
if sys.argv[1] == "pull":
  subprocess.call(["git", "submodule", "foreach", "git", "pull", "origin", "master"])

# Add a plugin from GitHub
if sys.argv[1] == "add":
  if not os.path.exists(".vim"):
    print("To add a plugin, you must run this script from the directory containing your .vim folder.")
    print("You are currently in", os.getcwd())
    sys.exit()
  else:
    repository = sys.argv[2].partition("/")
    user = repository[0]
    repo = repository[2]
    url = "git@github.com:" + user + "/" + repo
    dir = ".vim/bundle/" + repo
    print("Grabbing", repo, "from", user)
    subprocess.call(["git", "submodule", "add", "-f", url, dir])

# (Re)compile ycm_core (for YouCompleteMe)
if sys.argv[1] == "ycm_core":
  os.chdir(".vim/bundle/YouCompleteMe")
  subprocess.call(["./install.sh"])

# Quit
if cin is "q" or cin is None:
  sys.exit()
