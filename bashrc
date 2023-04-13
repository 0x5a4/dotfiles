# Test for an interactive shell.
if [[ $- != *i* ]] ; then
	return
fi

# Auto-launch fish(not if __KEEP_BASH is set)
[ -x /bin/fish ] && [ -z "$__KEEP_BASH" ] && SHELL=/bin/fish exec fish && exit

# Aliases
alias ls="ls -hl --color --hyperlink=auto --sort extension"
alias la="ls -A"
alias lsblk="lsblk -f"
alias sudo="sudo -v; sudo "
alias cat="bat"
alias ccat="command cat"

command -v zoxide &> /dev/null && eval "$(zoxide init bash)"

# Prompt
command -v starship &> /dev/null && eval "$(starship init bash)"
