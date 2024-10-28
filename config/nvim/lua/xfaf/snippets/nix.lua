return {
    s(
        "with",
        fmt([[
            with {}; {};
        ]], {
            i(1), i(2),
        })
    ),
    s(
        "withpkg",
        fmt([[
            with pkgs; [
                {}
            ];
        ]], {
            i(1),
        })
    ),
}
