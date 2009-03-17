export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:$PATH

# to fix coloring in less
export LESS=' --RAW-CONTROL-CHARS'

export EDITOR='vim'
if command -v mvim &> /dev/null; then
  export VISUAL='mvim'
elif command -v gvim &> /dev/null; then
  export VISUAL='gvim'
else
  export VISUAL=$EDITOR
fi

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

if [ -d ~/bin ] ; then
  PATH=~/bin:"${PATH}"
fi

source ~/.git-completion.bash
GIT_PS1_SHOWDIRTYSTATE='1'
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]$(__git_ps1 "\[\033[01;33m\](%s)\[\033[00m\]")\$ '

