return function()
    local Hydra = require('hydra')

    Hydra {
        name = "Window Resize",
        body = '<c-w>',
        config = {
            timeout = 4000,
        },
        heads = {
            -- Split
            { 'v', '<c-w>v' },
            { 's', '<c-w>s' },

            -- Resize
            { '>', '2<c-w>>', { desc = 'increase width' } },
            { '<', '2<c-w><', { desc = 'decrease width' } },
            { '+', '<c-w>+', { desc = 'increase height' } },
            { '-', '<c-w>-', { desc = 'decrease height' } },
            { '=', '<c-w>=', { desc = 'equalize', exit = true } },

            -- Exit
            { 'q', nil, { exit = true } }
        }
    }
end
