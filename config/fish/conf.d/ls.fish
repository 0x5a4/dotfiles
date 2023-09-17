if command -v eza &> /dev/null
    # -F show classify symbols
    # -M mount details
    # -n use numeric user/group ids
    # -o octal permissions
    alias 'ls'='command eza -FMno --no-user --color=auto --hyperlink --sort extension --git --git-repos-no-status --group-directories-first --icons'
    alias 'gls'='ls -l --git-ignore'
    alias 'tree'='ls --tree'
    alias 'ltree'='tree -l'
    alias 'gtree'='tree -l --git-ignore'
else
    alias 'ls'='command ls -h --classify=auto --color=auto --hyperlink=auto --sort extension'
end

alias 'l'='ls -l'
alias 'la'='ls -A'
