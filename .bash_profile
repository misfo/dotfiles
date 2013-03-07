export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:$PATH

for bindir in ~/node_modules/.bin ~/.cabal/bin ~/bin; do
  if [ -d "$bindir" ]; then
    PATH="$bindir:$PATH"
  fi
done

alias be='bundle exec'

export EDITOR='vim'
if command -v mvim &> /dev/null; then
  export VISUAL='mvim --nofork'
elif command -v gvim &> /dev/null; then
  export VISUAL='gvim --nofork'
elif command -v subl &> /dev/null; then
  export VISUAL='subl --wait'
else
  export VISUAL=$EDITOR
fi

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

if command -v brew > /dev/null && [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
else
  for dir in ~/Code /usr/share/git-core /usr/local/etc/bash_completion.d; do
    gitcomp="$dir/git-completion.bash"
    if [ -f "$gitcomp" ]; then
      source "$gitcomp"
      break
    fi
  done
fi

if command -v __git_ps1 &> /dev/null; then
  GIT_PS1_SHOWDIRTYSTATE='1'
  GIT_PS1='$(__git_ps1 "\[\033[01;33m\](%s)\[\033[00m\]")'
else
  GIT_PS1=''
fi

export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]$GIT_PS1\$ "

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

