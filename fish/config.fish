#Disable Greeting
set fish_greeting


#interactive mode only
if status is-interactive
	# vim all the way
	fish_vi_key_bindings
	set fish_cursor_default block
	set fish_cursor_insert block
	set fish_cursor_replace_one underscore
	set fish_cursor_visual block

	# Commands to run in interactive sessions can go here
	starship init fish | source
	if command -v zoxide &> /dev/null
		zoxide init fish | source
	end
end

#kitty ssh fix
if [ $TERM = 'xterm-kitty' ]
		alias 'ssh'='kitty +kitten ssh'
end

# aliases
alias 'cat'='bat'
alias 'ccat'='command cat'
alias 'la'='command ls -h --color --hyperlink=auto -l -a'
alias 'lsblk'='command lsblk -f'
alias ':q'='exit' # done that way to often
alias 'mkdirp'='mkdir -p'

# git shorts
alias 'gs'='git status'
alias 'gp'='git push'
alias 'ga'='git add'
alias 'gaa'='git add --all'
alias 'gcm'='git commit -m'
