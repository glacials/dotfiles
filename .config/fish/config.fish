function df
  df -h $argv
end;

function du
  du -h $argv
end;

function grep
  grep --color=auto $argv
end;

function less
  less -Ni $argv
end;

function vi
  vim $argv
end;

function c
  clear $argv
end;

function s
  screen -x $argv
end;

function p
  ps -Af | grep $argv
end;

function g
  git status $argv
end;

function ga
  git add $argv
end;

function gc
  git commit $argv
end;

function gp
  git push origin $argv
end;

uname -a | awk '{print $1}' | read kernel
switch $kernel
  case Darwin
    function ls
      ls -CFhG $argv
    end;
  case '*'
    function ls
      ls -CFh --color=auto $argv
    end;
end

function ll
  ls -l $argv
end;

function l
  ll $argv
end;

function la
  ll -a $argv
end;

function lr
  ll -R $argv
end;

function vim
  mvim $argv
end;

function fish_prompt
  if test (id -u) -eq "0"
    set uid_prompt "#"
  else
    set uid_prompt "\$"
  end;

  printf '%s%s@%s%s%s%s ' (set_color green -o) (whoami) (hostname|cut -d . -f 1):(pwd | sed 's/\/Users\/ben/~/g') (prompt_git) $uid_prompt (set_color normal)
end

function __fish_git_in_working_tree
  [ "true" = (git rev-parse --is-inside-work-tree ^ /dev/null; or echo false) ]
end

function __fish_git_dirty
  not git diff --no-ext-diff --quiet --exit-code ^ /dev/null
  or not git diff-index --cached --quiet HEAD ^ /dev/null
  or count (git ls-files --others --exclude-standard) > /dev/null
end

function __fish_git_current_head
  git symbolic-ref HEAD ^ /dev/null
  or git describe --contains --all HEAD
end

function __fish_git_current_branch
  __fish_git_current_head | sed -e "s#^refs/heads/##"
end 

function prompt_git 
  if __fish_git_in_working_tree
    if __fish_git_dirty
      set_color blue
    else
      set_color black
    end
    printf "|%s" (__fish_git_current_branch)
    set_color green -o
  end
end

function fish_greeting
  fortune | cowsay -n
end

function soy
  cd ~/Dropbox/school/chico/soywiki; soywiki; cd -
end

set SOYWIKI_VIM mvim
set PATH /usr/local/bin ~/.rvm/bin $PATH
bash ~/.rvm/scripts/rvm
