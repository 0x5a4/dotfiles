if status is-interactive
	# vim all the way
	fish_vi_key_bindings

	# Commands to run in interactive sessions can go here
	starship init fish | source

	if command -v thefuck &> /dev/null
		thefuck --alias | source
	end
end

