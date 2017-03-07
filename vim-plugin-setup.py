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
  print("    rm <plugin>       Remove a plugin by folder name (from .config/nvim/bundle)")
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
    print("To add a plugin, you must run this script from the folder containing your .config/nvim.")
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

# Remove a plugin by name
if sys.argv[1] == "rm":
  if not os.path.exists(".config/nvim"):
    print("Error: Can't find .config/nvim. Run this command from the folder containing your .config/nvim.")
    print("You are currently in {}.".format(os.getcwd()))
  else:
    plugin = sys.argv[2]
    dir = ".config/nvim/bundle/" + plugin
    print("Removing {}.".format(dir))
    subprocess.call(["git", "submodule", "deinit", dir])
    subprocess.call(["git", "rm", "--force", dir])
    subprocess.call(["git", "commit", "-m", "Remove {} Vim plugin".format(plugin)])

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
