function cl -d "cd into a directory and immediatly list its contents" -w cd
    cd $argv
    l $PWD
end
