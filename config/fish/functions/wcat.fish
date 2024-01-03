function wcat  -d "cat an executable" -w "command -v"
    cat (command -v $argv[1] || return)  
end
