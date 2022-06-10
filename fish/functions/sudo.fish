function sudo 
    # default behaviour if no args are given
    if test (count $argv) -eq 0
        command sudo
        return
    end

    # sudo arg tables
    set -l sudo_short_args "CDgpRUTu" 
    set -l sudo_long_args "close-from" "chdir" "group" "host" "prompt" "chroot" "other-user" "command-timeout" "user"

    # regexes
    set -l __long_arg_regex_or (string join \| $sudo_long_args)
    # Matches anything that expects an input in the next argv
    set -l arg_regex "^--(?:$__long_arg_regex_or)|^-[^-]*[$sudo_short_args]\$"
    # Matches everything else that is not the command
    set -l flag_regex "^--(?!$__long_arg_regex_or)\S+\$|^-[^-]*[^$sudo_short_args]\$"

    set -l sudov
    set -l commandv

    # Seperate sudo flags from the command
    for i in (seq 1 (count $argv))
        set -l arg $argv[$i]

        set -l flag_matches (string match -r $flag_regex -- $arg)
        set -l arg_matches (string match -r $arg_regex -- $arg)

        if set -q __force_push_sudov
            set -e __force_push_sudov
            set -a sudov $arg
        else if test (count $flag_matches) -ne 0
            set -a sudov $arg
        else if test (count $arg_matches) -ne 0
            set -a sudov $arg
            set __force_push_sudov
        else 
            set -a commandv $argv[$i..-1]
            break
        end
    end
     
    # Copy commandv to command
    set -l command $commandv

    # Resolve function
    if test (count $commandv) -ne 0
        set -l __func $commandv[1]

        if functions $__func > /dev/null
            # Create tempfile
            set tmpfile (mktemp fish.XXXXXX -p /tmp)
            chmod g+rw $tmpfile 
            functions $__func | tee $tmpfile > /dev/null

            # Modify command
            set command fish -c "source $tmpfile; $__func $commandv[2..-1]"
        end
    end

    # Call sudo
    command sudo $sudov $command
    
    # Delete tempfile
    if set -q tmpfile
        rm $tmpfile 2&> /dev/null
        set -e tmpfile
    end
end
