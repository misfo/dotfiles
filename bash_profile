export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:$PATH

# to fix coloring in less
export LESS=' --RAW-CONTROL-CHARS'

if [ -f /opt/local/etc/bash_completion.d/git ]; then
  . /opt/local/etc/bash_completion.d/git
fi

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
   
