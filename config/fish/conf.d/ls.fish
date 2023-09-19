set -l shared_opts -F --sort extension 

set -l exaopts -n --no-user --group-directories-first --git --icons
set -l ezaopts -Mo --hyperlink --git-repos-no-status

set -l opts $shared_opts


if set ls_impl $(command -v eza)
    set exa_available

    set -a opts $exaopts $ezaopts
else if set ls_impl $(command -v exa)
    set exa_available
    
    set -a opts $exaopts
else
    # neither exa nor eza are installed, so we stick with ls
    # 
    # -h for human readable numbers(exa/eza default)
    #
    # exa doesnt support hyperlinks so it cant be shared
    set ls_impl ls
    set -a opts -h --hyperlink=auto
end

alias 'ls'="$ls_impl $opts"

# if exa/eza are available, we can use them as tree
if set -q exa_available
    set -e exa_available
    
    alias 'gls'='ls -l --git-ignore'
    alias 'tree'='ls --tree'
    alias 'ltree'='tree -l'
    alias 'gtree'='tree -l --git-ignore'
end

alias 'l'='ls -l'
alias 'la'='ls -a'
