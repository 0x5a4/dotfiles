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
	alias 'sdown'='systemctl poweroff'
	alias 'nmcu'='nodemcu-tool'
	alias 'fishconf'='$EDITOR ~/.config/fish/config.fish'
	alias 'cat'='bat'
	alias 'gs'='git status'
	alias 'la'='ls -Al'
	alias 'lsblk'='command lsblk -f'
	alias ':q'='exit' # done that way to often
	
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

	# doas exists
	if not command -v doas &> /dev/null
		alias 'sudo'='command sudo -v; command sudo'
	end	

	#Disable Greeting
	set fish_greeting
end

