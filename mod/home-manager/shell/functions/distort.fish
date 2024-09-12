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
    set -l is_alphabet (string match -r "^[a-zA-Z]*\$" -- $character)

    if test (count $is_alphabet) -eq 0
        set result (string join "" $result $character)
        continue
    end

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
