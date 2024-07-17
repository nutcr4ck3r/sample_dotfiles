#####################
## SYSTEM SETTINGS ##
################################################################################
# history control
HISTFILE=$HOME/.zsh-history
HISTSIZE=10000               # Number of commands saved in history
SAVEHIST=10000               # Number of commands saved in history file
HISTORY_IGNORE="(cd|pwd|l[sal])"
zshaddhistory() {
  emulate -L zsh
  [[ ${1%%$'\n'} != ${~HISTORY_IGNORE} ]]
}
setopt hist_ignore_dups
setopt hist_ignore_all_dups  # For duplicate command lines, delete the old one
setopt hist_no_store
setopt share_history         # Share command history files
setopt append_history        # Add history (instead of creating .zsh_history every time)
setopt inc_append_history    # Add history incrementally
setopt hist_reduce_blanks    # Fill in any extra spaces and record

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

###################
## USER SETTINGS ##
################################################################################
# set vi mode
set -o vi
bindkey "jj" vi-cmd-mode

# functions
## cd and ls
case ${OSTYPE} in
  darwin*)
    lsoption='-G'
    ;;
  linux*)
    lsoption='--color=auto'
    ;;
esac
cdls ()
{
  \cd "$@" && echo -e "\e[32m[ MOVED >> \e[33m$(pwd)\e[32m ]\e[m" \
    && ls $lsoption
}

## colorfull man
man() {
  env \
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
}

## peco
function peco-history-selection() {
  BUFFER=$(history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle reset-prompt
  zle clear-screen
}
zle -N peco-history-selection

# set Alias
alias ls='ls $lsoption'
alias l='ls $lsoption'
alias ll='ls -lhF $lsoption'
alias la='ls -aF $lsoption'
alias lla='ls -lahF $lsoption'
alias tm='tmux'
alias cd='cdls'
alias w3m='w3m google.com'
alias k='kubectl'
alias d='sudo docker'
if type "nvim" > /dev/null 2>&1; then
  alias vim='nvim $1'
fi
bindkey "^K" peco-history-selection
case ${OSTYPE} in
  darwin*)
    export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
    export LESS=' -R '
    ;;
  linux*)
    export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
    export LESS=' -R '
    ;;
esac

# Prompt settings
# set path
export PATH=${PATH}:/snap/bin
export PATH=${PATH}:/opt/java/jdk/bin
export PATH=${PATH}:$HOME/.local/bin

# Show Git branch information
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*'     formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*'     actionformats '[%b|%a]'
precmd () { vcs_info }

# Show Bigin/End time for commands
export PREV_COMMAND_END_TIME
export NEXT_COMMAND_BGN_TIME

function show_command_end_time() {
  PREV_COMMAND_END_TIME=`date "+%Y-%m-%d %H:%M:%S %Z"`
  PROMPT="
%F{237}IN: ${PREV_COMMAND_END_TIME}%f
%F{cyan}[%n]%f%F{blue}[%~]%f%F{green}"'${vcs_info_msg_0_}
%F{red}>%F{yellow}>%F{green}>%f%b '
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd show_command_end_time

show_command_begin_time() {
  NEXT_COMMAND_BGN_TIME=`date "+%Y-%m-%d %H:%M:%S %Z"`
  PROMPT="
%F{237}IN: ${PREV_COMMAND_END_TIME} -> OUT: ${NEXT_COMMAND_BGN_TIME}%f
%F{cyan}[%n]%f%F{blue}[%~]%f%F{green}"'${vcs_info_msg_0_}
%F{red}>%F{yellow}>%F{green}>%f%b '
  zle .accept-line
  zle .reset-prompt
}
zle -N accept-line show_command_begin_time
