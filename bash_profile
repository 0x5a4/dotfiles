PATH=${PATH}:~/.local/bin:~/.cargo/bin

# if these are missing everything dies
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
# please leave my alone
rmdir ~/Desktop &> /dev/null

if [[ -f ~/.bashrc ]] ; then
    . ~/.bashrc
fi
