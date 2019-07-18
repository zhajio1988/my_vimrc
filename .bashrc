# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

function git-branch-name {
  git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3
}
function git-branch-prompt {
    local branch=`git-branch-name`
    if [ $branch ]; then printf "[%s]" $branch; fi
}

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[0;32m\]\u\[\033[00m\]: \[\033[0;34m\]\w\[\033[00m\]\$ '
else
    if [[ -z $(git-branch-prompt) ]]; then
        PS1='\[\033[0;32m\]\h\[\033[00m\]: \[\033[0;34m\]\w\[\033[00m\]\$ '
    else 
        PS1="\[\033[0;32m\]\$(git-branch-prompt)\[\033[0m\]: \[\033[0;34m\]\w\[\033[0m\]\$ "
    fi
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto -F'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#export HTTP_PROXY="http://10.5.112.53:80"
#export HTTPS_PROXY="https://10.5.112.53:80"

export PATH="$PATH"
PATH=$PATH:$HOME/bin
# some more ls aliases
alias a="alias"
a ll='ls -alF'
a la='ls -A'
a l='ls -CF'
a h="history"
a l="ls -A -l -t -r "
a lt="ls -Atrlh"
a ll="ls -lsAgh"
a lm="ls -aslg | more"
a lg="ls -lsag"
a la="ls -lsA"
a dir="ls -lag | more"
a clr="clear"
a gr='grep -n -R --exclude-dir=.svn --color=auto'
a gv="gvim -geom=185x45+0+10"
a gf='gv $(fzf)'
a g="gv -geom=185x45-0+50"
a gn='gvim -u "NONE"'
# a diff=diff -qubr
#a pd="pushd \!* > /dev/null ;"
a ..="cd .."
a ...="cd ../.."
a ....="cd ../../.."
a fcd='cd $(find * -type d | fzf)'

a kt='"konsole --nofork --geometry=800x600&"'
a gt='gnome-terminal --geometry=80x24+0+10&'
a pdf='evince'
#a tee='2>&1 | tee'
a svctags='exctags -R --sort=yes --extras=+q --fields=+i --languages=SystemVerilog `pwd`'
a cctags='exctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extras=+q --languages=C++ `pwd`'
#-R --c++-kinds=+p --fields=+iaS --extra=+q
a rm='rm -i'

a psm='"ps -ef|grep "`whoami`""'
a ps_apt='"ps -A | grep apt-get"'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

_gvComplete()
{
    COMPREPLY=()
    local cur=${COMP_WORDS[COMP_CWORD]};
    local prev=${COMP_WORDS[COMP_CWORD-1]};
    compopt -o nospace
   COMPREPLY=( $(compgen  -d -f -- $cur) )
    
    #if [[ -d "${cur}" ]]; then
    #    local pro=($(pwd))
    #    cd ${cur}
    #    cmd_opts=`ls`;
    #    compopt -o nospace
    #    COMPREPLY=($(compgen -W "${cmd_opts}" -- $cur))
    #    cd $pro
    #else
    #    compopt -o nospace
    #    COMPREPLY=( $(compgen  -d -f -- $cur) )
    #fi

    return 0
}
complete -F _gvComplete gv

export LD_LIBRARY_PATH=/usr/local/lib
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
