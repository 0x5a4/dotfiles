# equery belongs executable
function eqbexe -d "List packages owning specified commands" --wraps "which"
    if test (count $argv) -eq 0 
        echo "usage: eqbexe [NAMES]..." 

        return 1
    end

    set -l exe_files

    for cmd in $argv 
        set -a exe_files (which $cmd) || return 1
    end

    equery belongs $exe_files
end
