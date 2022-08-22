#####################
## SYSTEM SETTINGS ##
################################################################################
# history control
HISTFILE=$HOME/.zsh-history
HISTSIZE=10000               # ヒストリに保存するコマンド数
SAVEHIST=10000               # ヒストリファイルに保存するコマンド数
HISTORY_IGNORE="(cd|pwd|l[sal])"
zshaddhistory() {
  emulate -L zsh
  [[ ${1%%$'\n'} != ${~HISTORY_IGNORE} ]]
}
setopt hist_ignore_dups
setopt hist_ignore_all_dups  # 重複するコマンド行は古い方を削除
setopt hist_no_store
setopt share_history         # コマンド履歴ファイルを共有する
setopt append_history        # 履歴を追加 (毎回 .zsh_history を作るのではなく)
setopt inc_append_history    # 履歴をインクリメンタルに追加
setopt hist_reduce_blanks    # 余分な空白は詰めて記録

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

## history search by peco
function peco-history-selection() {
    BUFFER=`history -n 1 | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection

## Check git status (push)
function _git_not_pushed() {
    if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
      head="$(git rev-parse HEAD)"
      for x in $(git rev-parse --remotes)
      do
        if [ "$head" = "$x" ]; then
          return 0
        fi
      done
      echo "^"
    fi
    return 0
  }

# set Alias
alias ls='ls $lsoption'
alias l='ls $lsoption'
alias ll='ls -lhF $lsoption'
alias la='ls -aF $lsoption'
alias lla='ls -lahF $lsoption'
alias cd='cdls'
# alias tmux='tmux -2'
alias w3m='w3m google.com'
alias ghidra='~/app/ghidra_10.0.3_PUBLIC/ghidraRun'
alias remnux='sudo docker exec -it rem /bin/bash'
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

# set path
export PATH=${PATH}:/snap/bin
export PATH=${PATH}:/opt/java/jdk/bin
export PATH=${PATH}:$HOME/.local/bin
export PATH=${PATH}:$HOME/git/dotfiles/bin
export PATH=${PATH}:/home/user/git/dotfiles/bin
export PATH=${PATH}:$HOME/.nodebrew/current/bin
export PATH=${PATH}:/usr/local/opt/mysql-client/bin

# for pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/shims:$PATH"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
if [[ $(which pyenv) == 'true' ]] ; then
  eval "$(pyenv init -)"
fi

# prompt settings.
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats "%F{green}%c%u[%s(%b)]%f"  # Git(branch)
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"       # Staged & no-commit.
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"        # Unstaged.
zstyle ':vcs_info:*' actionformats '(%s)[%b|%a]'       # Error. (ex.conflict)
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
  [[ $(git ls-files --other --directory --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]] ; then
  hook_com[unstaged]+='%F{red}?'
fi
}
precmd () { vcs_info }
setopt prompt_subst
# PROMPT = [user_name][path][git_push][git_app|branch]
PROMPT='
%B%F{cyan}[%n]%f%F{blue}[%~]%f%F{green}\
$(_git_not_pushed)%f${vcs_info_msg_0_}
%F{red}>%F{yellow}>%F{green}>%f%b '
