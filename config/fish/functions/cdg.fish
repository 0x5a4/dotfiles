function cdg -d "change working directory to the git root"
    set __git_root (git rev-parse --show-toplevel)
    if test $status -eq 0
        cd $__git_root
    end
end
