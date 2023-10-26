
# if these are missing everything dies
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Behave GHCup, behave
export GHCUP_USE_XDG_DIRS="i beg you"

# You too Go
export GOPATH=$HOME/.go

# AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
# please leave my alone
rmdir ~/Desktop &> /dev/null

# needs to be prepended, otherwise rustup's toolchains get ignored and shit like that
PATH=~/.local/bin:~/.cargo/bin:~/.go/bin:${PATH}

if [[ -f ~/.bashrc ]] ; then
    . ~/.bashrc
fi
