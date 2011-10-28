Instructions
------------
1. `git clone` into wherever you want (I use `~/.helpers` for stuff like this).
2. Add these lines to your `~/.bashrc`, replacing `~/.helpers` as necessary:
  - `export UN=~/.helpers/un`
  - `. $UN/un.sh`
3. `source ~/.bashrc`
4. Test it out with something like
  - `touch test`
  - `un`

How It Works
------------
`un` uses your shell's built-in `history` function to grab the last thing you
did, then reverses it according to a template for that command in the
`templates` folder. `un` cannot undo something that it doesn't know about.

Development
-----------
If you have a template to add, pull request me.
