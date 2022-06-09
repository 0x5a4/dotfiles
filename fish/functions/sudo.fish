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

    for i in (seq 1 (count $argv))
        set -l arg $argv[$i]

        set -l flag_matches (string match -r $flag_regex -- $arg)
        set -l arg_matches (string match -r $arg_regex -- $arg)
        
        echo isflag: (test (count $flag_matches) -ne 0) or "no"

        if set -q __force_push_sudov
            set -e __force_push_sudov
            set -a sudov $arg
        elseif test (count $flag_matches) -ne 0
            echo ITS A FLAG
            set -a sudov $arg
        elseif test (count $arg_matches) -ne 0
            set -a sudov $arg
            set __force_push_sudov
        else 
            set -a command $argv[$i..2]
            break
        end
    end

    echo "sudov: $sudov"
    echo "command: $command"
end
