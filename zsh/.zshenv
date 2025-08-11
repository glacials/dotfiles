if [ -r "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin${PATH:+:$PATH}"
