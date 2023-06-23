function distort -d "alternates capitalization for the given string"
    set -l input
    
    if test (count $argv) -eq 0
        read input
    else
        set input $argv[1]
    end

    set flag
    set -l result ""
    for i in (seq 1 (string length $input))
        set -l character (string sub -l1 -s$i $input)

        if set -q flag
            set result (string join "" $result (string lower $character))
            set -e flag
        else
            set result (string join "" $result (string upper $character))
            set flag
        end
    end

    set -e flag

    echo $result
end
