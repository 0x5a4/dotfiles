return {
    s(
        "let",
        fmt([[
        (let [{}]
            {})
        ]], {
            i(1), i(2),
        })
    ),
    s(
        "def",
        {
            t("(def "),
            i(1),
            t(")"),
        }
    ),
    s(
        "defn",
        fmt([[
            (defn {} [{}]
                {})
        ]], {
            i(1), i(2), i(3),
        })
    ),
    s(
        "defmacro",
        fmt([[
            (defmacro {} [{}]
                {})
        ]], {
            i(1), i(2), i(3),
        })
    ),
    s(
        "defmethod",
        fmt([[
            (defmethod {} {} [{}]
                {})
        ]], {
            i(1), i(2), i(3), i(4),
        })
    ),
    s(
        "if",
        fmt([[
            (if {}
                {}
                {})
        ]], {
            i(1), i(2), i(3),
        })
    ),
    s(
        "loop",
        fmt([[
            (loop [{}]
                {})
        ]], {
            i(1), i(2),
        })
    ),
}
