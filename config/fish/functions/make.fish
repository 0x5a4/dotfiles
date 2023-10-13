function make -w make

    # preserve original PWD
    pushd $PWD
    set -x GNU_MAKE_EXEC_DIR "$PWD"

    # if GNU_MAKE_ROOT_DIR is set, move there
    if set -q GNU_MAKE_ROOT_DIR
        cd $GNU_MAKE_ROOT_DIR
    end

    # execute order 66
    command make $argv

    # cleanup our garbage
    set -e GNU_MAKE_EXEC_DIR
    popd
end
