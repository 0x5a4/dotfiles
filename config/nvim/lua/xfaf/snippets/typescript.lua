return {
    s(
        "test",
        fmt([[
        test("{}", async ({{{}}}) => {{
            {}
        }});
        ]], {
            i(1), i(2), i(3)
        })
    ),
    s(
        "graphql_query",
        fmt([[
            const {} = {{
                data: {{
                    query: `
                        {}
                    `,
                }},
            }};

            const {} = await request.post({}, {});
            expect({}.status()).toBe(200);
            expect({}.ok()).toBeTruthy();

            const {} = await {}.json().data;
        ]], {
            i(1, "query"),
            i(2),
            i(3, "response"),
            i(4, "endpoint"),
            rep(1),
            rep(3),
            rep(3),
            i(5, "body"),
            rep(3),
        })
    )
}
