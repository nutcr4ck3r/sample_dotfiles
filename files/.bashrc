#!/bin/bash

#####################
## SYSTEM SETTINGS ##
################################################################################
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# history control
export HISTCONTROL=ignoreboth
export HISTIGNORE="cd*:ls*:l*:history"
export HISTSIZE=10000

# history search by peco
function peco-select-history() {
    local tac
    which gtac &> /dev/null && tac="gtac" || \
        which tac &> /dev/null && tac="tac" || \
        tac="tail -r"
    READLINE_LINE=$(HISTTIMEFORMAT= history | $tac | \
      sed -e 's/^\s*[0-9]\+\s\+//' | \
      awk '!a[$0]++' | \
      peco --query "$READLINE_LINE")
    READLINE_POINT=${#READLINE_LINE}
}
bind -x '"\C-k": peco-select-history'

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && \
      eval "$(dircolors -b ~/.dircolors)" || \
      eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Add sbin directories to PATH.  This is useful on systems that have sudo
echo $PATH | grep -Eq "(^|:)/sbin(:|)"     || PATH=$PATH:/sbin
echo $PATH | grep -Eq "(^|:)/usr/sbin(:|)" || PATH=$PATH:/usr/sbin
# conversion code to color name
red='\[\e[0;31m\]'
RED='\[\e[1;31m\]'
blue='\[\e[0;34m\]'
BLUE='\[\e[1;34m\]'
cyan='\[\e[0;36m\]'
CYAN='\[\e[1;36m\]'
green='\[\e[0;32m\]'
GREEN='\[\e[1;32m\]'
yellow='\[\e[0;33m\]'
YELLOW='\[\e[1;33m\]'
PURPLE='\[\e[1;35m\]'
purple='\[\e[0;35m\]'
nc='\[\e[0m\]'

###################
## USER SETTINGS ##
################################################################################
# set vi mode
set -o vi
bind '"jj": vi-movement-mode'

# prompt setting
## set default prompt
PS1="\n$BLUE\u$nc@$CYAN\H$nc:$GREEN\w$nc\n$RED>$YELLOW>$GREEN>$nc "

# function
## cd and ls
cdls ()
{
  \cd "$@" && echo -e "\e[32m[ MOVED >> \e[33m$@\e[32m ]\e[m" && ls
}
## colorfull man
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# aliases
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'
alias lla='ls -lahF'
alias cd='cdls'
alias so='source ~/.bashrc'
vim_version=$(vim --version | head -1 | sed 's/^.*\ \([0-9]\)\.\([0-9]\)\ .*$/\1\2/')
alias less='/usr/share/vim/vim${vim_version}/macros/less.sh'
# load bash aliases files
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# set user's path & environment
export PATH=${PATH}:/opt/java/jdk-11.0.2/bin
export PATH=${PATH}:$HOME/.local/bin
export PATH=${PATH}:$HOME/git/home/bin
JAVA_HOME=/opt/java/jdk-11.0.2
. "$HOME/.cargo/env"
