#Disable Greeting
set fish_greeting

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
        source /usr/share/fzf/key-bindings.fish
        fzf_key_bindings
    end
end

# aliases
alias 'cat'='bat'
alias 'ccat'='command cat'
alias 'l'='ls'
alias 'la'='ls -A'
alias 'lsblk'='command lsblk -f'
alias ':q'='exit' # done that way to often
alias 'mkdirp'='mkdir -p'
alias 'tt'='tutel'

# git shorts
alias 'gs'='git status'
alias 'gd'='git diff'
alias 'ga'='git add'
alias 'gl'='git log --oneline'
alias 'gaa'='git add --all'
alias 'gcm'='git commit -m'

# XDG things
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_CACHE_HOME "$HOME/.cache"
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x XDG_STATE_HOME "$HOME/.local/state"
fish_add_path /home/arthur/.spicetify
