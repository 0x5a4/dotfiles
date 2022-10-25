# XDG BASE DIRS
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

#ZSH CONFIG
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="${HOME}/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS
export ZPLUG_HOME="${HOME}/.zplug"
unsetopt BEEP
unsetopt LIST_BEEP

path+=('~/.cargo/bin/')
export PATH
