#!/usr/bin/env python3

import os
import subprocess
import sys

cin = None

if len(sys.argv) is 1 or (sys.argv[1] == "add" and len(sys.argv) < 3):
  print("Usage: {} <command>".format(sys.argv[0]))
  print("")
  print("Commands are:")
  print("    init              Initialize all Vim plugins")
  print("    update            Checkout assigned commits in each submodule")
  print("    pull              Pull all Vim plugins")
  print("    add <user/repo>   Add a Vim plugin from GitHub repository at user/repo")
  if os.path.exists(".config/nvim/bundle/YouCompleteMe"):
    print("    ycm_core          Recompile ycm_core for YouCompleteMe")
  if os.path.exists(".config/nvim/bundle/Command-T"):
    print("    command-t         Compile the C extension for Command-T")
  sys.exit()

# Init plugins
if sys.argv[1] == "init":
  subprocess.call(["git", "submodule", "init"])
  subprocess.call(["git", "submodule", "update", "--recursive"])

# Checkout the correct commits in each plugin
if sys.argv[1] == "pull":
  subprocess.call(["git", "submodule", "update"])

# Pull each plugin
if sys.argv[1] == "pull":
  subprocess.call(["git", "submodule", "foreach", "git", "pull", "origin", "master"])

# Add a plugin from GitHub
if sys.argv[1] == "add":
  if not os.path.exists(".config/nvim"):
    print("To add a plugin, you must run this script from the directory containing your .config/nvim folder.")
    print("You are currently in {}.".format(os.getcwd()))
    sys.exit()
  else:
    repository = sys.argv[2].partition("/")
    user = repository[0]
    repo = repository[2]
    url = "git@github.com:" + user + "/" + repo
    dir = ".config/nvim/bundle/" + repo
    print("Grabbing {}/{}.".format(user, repo))
    subprocess.call(["git", "submodule", "add", "-f", url, dir])
    subprocess.call(["git", "commit", "-m", "Add {}/{}".format(user, repo)])

# (Re)compile ycm_core (for YouCompleteMe)
if sys.argv[1] == "ycm_core":
  os.chdir(".config/nvim/bundle/YouCompleteMe")
  subprocess.call(["./install.sh"])

if sys.argv[1] == "command-t":
    os.chdir(".config/nvim/bundle/Command-T/ruby/command-t")
    subprocess.call(["ruby", "extconf.rb"])
    subprocess.call(["make"])

# Quit
if cin is "q" or cin is None:
  sys.exit()
