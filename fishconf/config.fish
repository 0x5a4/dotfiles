#ENVIRONMENT VARIABLES
set EDITOR nvim


if status is-interactive
	# vim all the way
	fish_vi_key_bindings

	# Commands to run in interactive sessions can go here
	if command -v starship &> /dev/null && not contains "linux" $TERM
		starship init fish | source
	end

	if command -v thefuck &> /dev/null
		thefuck --alias | source
	end

	# aliases
  alias 'sdown'='shutdown -h now'
  alias 'sudo'='command sudo -v; command sudo'
  alias 'gaytrain'='command sl | command lolcat && clear'
  alias 'nmcu'='nodemcu-tool'
  alias 'fishconf'='$EDITOR ~/.config/fish/config.fish'
  alias 'cat'='bat'
  alias 'gs'='git status'
	
	#kitty ssh fix
	if [ $TERM = 'xterm-kitty' ]
			alias 'ssh'='kitty +kitten ssh'
	end

	#man with color
	if command -v batman &> /dev/null 
		alias 'man'='batman'
	end

	#Disable Greeting
	set fish_greeting

end

