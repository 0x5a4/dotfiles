function ccd -d "cd into a directory and create it" -w cd
    if not test (count $argv) -eq 1
        echo "Wrong argument count for ccd"
        return 1
    end

    if not test -e $argv[1]
        mkdir -p $argv[1] 
    end

    cd $argv[1]
end
