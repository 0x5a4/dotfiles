if status is-interactive
	# vim all the way
	fish_vi_key_bindings

	# Commands to run in interactive sessions can go here
	starship init fish | source

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
end

