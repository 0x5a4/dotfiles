#Disable Greeting
set fish_greeting

#                   XXXXXXXXXXXXX
#                   X My entire X
#                   X system    X
#                   XXXXXXXXXXXXX
#                    |      XXX
# XDG_CONFIG_HOME -> |      XXX
#                   ------------
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_CACHE_HOME "$HOME/.cache"
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x XDG_STATE_HOME "$HOME/.local/state"

# Behave GHCup, behave
set -x GHCUP_USE_XDG_DIRS "i beg you"

# You too Go
set -x GOPATH $HOME/.go

#interactive mode only
if status is-interactive
	set fish_cursor_default block
	set fish_cursor_insert block
	set fish_cursor_replace_one underscore
	set fish_cursor_visual block

	# Commands to run in interactive sessions can go here
    if command -v starship &> /dev/null
        starship init fish | source
    end

	if command -v zoxide &> /dev/null
		zoxide init fish | source
	end

    if command -v fzf &> /dev/null
        if command -v fzf-share &> /dev/null
            # nix is weird
            source (fzf-share)/key-bindings.fish
        else
            source /usr/share/fzf/key-bindings.fish
        end
        fzf_key_bindings
    end
end

fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.go/bin

set fisher_path "$XDG_CONFIG_HOME/fish/plugins"
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..]
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..]

for file in $fisher_path/conf.d/*.fish
    source $file
end

# remove gitnow binds
for keys in \es \ee \ce \em \ec \ed \ep \eu \el \ef \eh
    bind --user -e $keys
end

# source home manager session
if command -v home-manager 2&> /dev/null
    fenv source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
end
    
# aliases
alias 'cat'='bat'
alias 'ccat'='command cat'
alias 'lsblk'='command lsblk -f'
alias ':q'='exit' # done that way to often
alias 'mkdirp'='mkdir -p'
alias 'tt'='tutel'

# git shorts
alias 'gs'='git status -sb'
alias 'gd'='git diff'
alias 'gdc'='git diff --cached'
alias 'ga'='git add'
alias 'gl'='git lg'
alias 'gaa'='git add --all'
alias 'gcm'='git commit -m'
