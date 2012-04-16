export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:$PATH

# rbenv
if [ -d ~/.rbenv ] ; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# to fix coloring in less
export LESS=' --RAW-CONTROL-CHARS'

export EDITOR='vim'
if command -v subl &> /dev/null; then
  export VISUAL='subl --wait'
elif command -v mvim &> /dev/null; then
  export VISUAL='mvim --nofork'
elif command -v gvim &> /dev/null; then
  export VISUAL='gvim --nofork'
else
  export VISUAL=$EDITOR
fi

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

if [ -d ~/bin ] ; then
  PATH=~/bin:"${PATH}"
fi

if [ -f ~/Code/git-completion.bash ]; then
  source ~/Code/git-completion.bash
fi
if command -v __git_ps1 &> /dev/null; then
  GIT_PS1_SHOWDIRTYSTATE='1'
  GIT_PS1='$(__git_ps1 "\[\033[01;33m\](%s)\[\033[00m\]")'
else
  GIT_PS1=''
fi

export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]$GIT_PS1\$ "

