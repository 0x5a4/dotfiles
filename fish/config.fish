#ENVIRONMENT VARIABLES
set -x EDITOR nvim

if status is-interactive
	# vim all the way
	fish_vi_key_bindings
	set fish_cursor_default block
	set fish_cursor_insert block
	set fish_cursor_replace_one underscore
	set fish_cursor_visual block

	if contains "linux" $TERM
		set -x LINUXTERM LINUX
	end

	# Commands to run in interactive sessions can go here
	if command -v starship &> /dev/null && not set -q LINUXTERM
		starship init fish | source
	end

	if command -v thefuck &> /dev/null
		thefuck --alias | source
	end

	# aliases
	alias 'sdown'='shutdown -h now'
	alias 'nmcu'='nodemcu-tool' # will propably never use it again but this stays
	alias 'fishconf'='$EDITOR ~/.config/fish/config.fish'
	alias 'cat'='bat'
	alias 'la'='ls -A'
	alias 'lsblk'='command lsblk -f'
	alias ':q'='exit' # done that way to often

	# git shorts
	alias 'gs'='git status'
	alias 'gp'='git push'
	
	#kitty ssh fix
	if [ $TERM = 'xterm-kitty' ]
			alias 'ssh'='kitty +kitten ssh'
	end

	if command -v tutel &> /dev/null 
		tutel nav init fish | source
	end

	#man with color
	if command -v batman &> /dev/null 
		alias 'man'='batman'
	end

	#Disable Greeting
	set fish_greeting
end

