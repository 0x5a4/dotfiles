return {
    s(
        "bind",
        fmt([[
            bind{} = {}, {}, {}
        ]], {
            i(0),
            i(1, "$mainMod"),
            i(2),
            i(3, "exec"),
        })
    ),
    s(
        "windowrule",
        fmt([[
            windowrule={}, {}
        ]], {
            i(1), i(2),
        })
    ),
}
