function ecat  -d "cat an ebuild" -w "equery which"
    cat (equery which $argv[1] || return)  
end
