if status is-interactive
	# Commands to run in interactive sessions can go here
	starship init fish | source

end

if command -v thefuck &> /dev/null
	thefuck --alias | source
end
