function ecat  -d "show an ebuild" -w "equery which"
    cat (equery which $argv[1] || return)  
end
