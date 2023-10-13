function make -w make
    pushd $PWD

    if set -q GNU_MAKE_ROOT_DIR
        cd $GNU_MAKE_ROOT_DIR
    end

    command make $argv

    popd
end
