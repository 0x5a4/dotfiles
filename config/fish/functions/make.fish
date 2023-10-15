function make -w make

    set -l makeargs $argv

    # if GNU_MAKE_ROOT_DIR is set, execute the makefile located there
    if set -q GNU_MAKE_ROOT_DIR
        set -l makefiles "Makefile" "makefile" "GNUMakefile"

        for makefile in $makefiles
            if test -e "$GNU_MAKE_ROOT_DIR/$makefile"
                set -a makeargs -sf "$GNU_MAKE_ROOT_DIR/$makefile"
            end
        end
    end

    # execute order 66
    command make $makeargs
end
