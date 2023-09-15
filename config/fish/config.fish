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
if command -v bat &> /dev/null
    alias 'cat'='bat'
else if command -v batcat &> /dev/null # fuck you debian, fuck you
    alias 'cat'='batcat'
end
    
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
