# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

export TERM="screen-256color"

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
export EDITOR="nvim"
export SSH_KEYS_HOMEDIR="${HOME}/.ssh"

# override the dreaded XDG_CONFIG_HOME
export XDG_CONFIG_HOME="$HOME/.config"
export GOPATH="$HOME/Work/go"

# PATH
#PATH=$PATH:/opt/android-sdk/tools:/opt/android-sdk/platform-tools:/opt/android-sdk/build-tools/19.0.0:$GOPATH/bin:$HOME/.gem/ruby/2.4.0/bin
PATH=$PATH:$GOPATH/bin:$HOME/.gem/ruby/2.4.0/bin

# color schemes
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
source $HOME/.base16_theme

# Fuzzy finder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTIONS="--extended --cycle --border --height=25 --inline-info --ansi --prompt='FZF> ' --header='Type in your query:'"
bind -x '"\C-p": "z=$(fzf);"'

# w3m default homepage
WWW_HOME="https://start.duckduckgo.com"
export WWW_HOME

# GPG Agent stuff
GPG_TTY=$(tty)
export GPG_TTY
# PASS password-store path
PASSWORD_STORE_DIR="${HOME}/Work/dotfiles/config/password-store"
export PASSWORD_STORE_DIR

# source functions
source ~/Work/dotfiles/bash_prompt_functions
source ~/Work/dotfiles/fastweb-aliases

# The Fuck
eval $(thefuck --alias)

# set vi mode
#set -o vi

# git-tmux integration
[ -x ~/.tmux/plugins/tmux-git/scripts/git.sh ] && ~/.tmux/plugins/tmux-git/scripts/git.sh

# Draw PS1
PROMPT_COMMAND=draw_ps1

