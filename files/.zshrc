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

# set Alias & Keybinding
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
alias so='source ~/.zshrc'
alias cdp='pa cd'
alias lsp='pa ls'
alias vip='pa vi'
alias vimp='pa vim'
alias lessp='pa less'
alias catp='pa cat'
alias morep='pa more'
alias findp='pa find'
alias rmp='pa rm'
alias cpp='pa cp'
alias mvp='pa mv'
bindkey "^K" fzf-history-selection
bindkey "^U" fzf-cdr

# set path
export PATH=${PATH}:/snap/bin
export PATH=${PATH}:/opt/java/jdk/bin
export PATH=${PATH}:$HOME/.local/bin
export PATH=${PATH}:$HOME/git/dotfiles/bin
export PATH=${PATH}:$HOME/git/dotfiles/bin
export PATH=${PATH}:$HOME/.nodebrew/current/bin
export PATH=${PATH}:/usr/local/opt/mysql-client/bin
# colorful man page
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
# for pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# for ranger
export EDITOR=vim

#####################
## PROMPT SETTINGS ##
################################################################################
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

###############
## Functions ##
################################################################################
# highlighting less
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

# cd and ls
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

# Command History Search by fzf
function fzf-history-selection() {
  BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle reset-prompt
  zle clear-screen
}
zle -N fzf-history-selection

# DirPath History Search & Move by fzf
[[ ! -d "${XDG_CACHE_HOME:-$HOME/.cache}/shell/" ]] && mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/shell/"

if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':completion:*:*:cdr:*:*' menu selection
  zstyle ':completion:*' recent-dirs-insert both
  zstyle ':chpwd:*' recent-dirs-max 500
  zstyle ':chpwd:*' recent-dirs-file "${XDG_CACHE_HOME:-$HOME/.cache}/shell/chpwd-recent-dirs"
fi
fzf-cdr() {
  local dest=$(cdr -l | sed 's/^\s*[0-9]*\s*//' | fzf --query "$LBUFFER" --preview 'ls {}')
  [[ -n $dest ]] && BUFFER="cd $dest" && zle accept-line
}
zle -N fzf-cdr

# 'pa' function: command wrapper for interactive file/directory selection using 'find' and 'fzf'.
# Supports commands: cd, ls, vi, vim, less, cat, more, find, rm, cp, mv.
export FZF_DEFAULT_OPTS='--reverse --border --preview-window=down --bind "ctrl-t:change-preview-window:right|hidden|down"'
pa() {
  local cmd="$1"; shift
  local args="$@"
  local selected_path=""
  local dst_path=""

  # Path selection
  case "$cmd" in
    cd|ls)
      selected_path=$(find ${args:-.} -type d 2> /dev/null | fzf --preview 'ls {}')
      ;;
    vi|vim|less|cat|more)
      selected_path=$(find ${args:-.} -type f 2> /dev/null | fzf --preview 'bat --style=numbers --color=always {} 2> /dev/null')
      ;;
    find)
      selected_path=$(find ${args:-.} 2> /dev/null | fzf --preview 'bat --style=numbers --color=always {} 2> /dev/null || head -100 {} 2> /dev/null || ls {}')
      [ -z "$selected_path" ] && { echo "[!] No selection made."; return; }
      [ -d "$selected_path" ] && cd "$selected_path" || cd "$(dirname "$selected_path")"
      return
      ;;
    rm)
      selected_path=$(find ${args:-.} 2> /dev/null | fzf --preview 'bat --style=numbers --color=always {} 2> /dev/null || head -100 {} 2> /dev/null || ls {}')
      [ -z "$selected_path" ] && { echo "[!] No selection made."; return; }
      echo -n "[?] Delete '$selected_path'? yes/no: "; read confirm
      [[ "$confirm" =~ ^(yes|y|Y)$ ]] && rm -r "$selected_path" || echo "[!] Deletion cancelled."
      return
      ;;
    cp|mv)
      [[ -n "$args" ]] && selected_path=$(find $args -type f 2> /dev/null | fzf --preview 'bat --style=numbers --color=always {} 2> /dev/null || head -100 {} 2> /dev/null') || { echo -n "[?] Enter source path: "; read input_path; selected_path=$(find ${input_path:-.} -type f 2> /dev/null | fzf --preview 'bat --style=numbers --color=always {} 2> /dev/null || head -100 {} 2> /dev/null'); }
      [ -z "$selected_path" ] && { echo "[!] No selection made."; return; }
      echo -n "[?] Enter destination path: "; read dst_input_path
      dst_path=$(find ${dst_input_path:-.} -type d 2> /dev/null | fzf --preview 'ls {}')
      [ -z "$dst_path" ] && { echo "[!] No destination selected."; return; }
      if [ -e "$dst_path/$(basename "$selected_path")" ]; then
        echo -n "[?] Overwrite existing file? yes/no: "; read overwrite_confirm
        [[ ! "$overwrite_confirm" =~ ^(yes|y|Y)$ ]] && { echo "[!] $cmd cancelled."; return; }
      fi
      echo -n "[?] Confirm $cmd '$selected_path' to '$dst_path'? yes/no: "; read confirm
      [[ "$confirm" =~ ^(yes|y|Y)$ ]] && $cmd "$selected_path" "$dst_path" || echo "[!] $cmd cancelled."
      return
      ;;
    *)
      echo "[!] No matching action."; return
      ;;
  esac

  [ -z "$selected_path" ] && { echo "[!] No selection made."; return; }
  echo "[-] Executing command: $cmd $selected_path"
  [ "$cmd" = "cd" ] && cd "$selected_path" || eval "$cmd $selected_path"
}
