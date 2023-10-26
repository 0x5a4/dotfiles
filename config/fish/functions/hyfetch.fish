function hyfetch -w hyfetch 
    set -l hyfetch_args
    if command -v fastfetch &> /dev/null
        set -a hyfetch_args -b fastfetch
    end

    command hyfetch $hyfetch_args $argv
end
