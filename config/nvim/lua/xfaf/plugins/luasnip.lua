return {
    "L3MON4D3/LuaSnip",
    lazy = true,
    config = function()
        local luasnip = require("luasnip")
        
        luasnip.config.set_config({
            region_check_events = { "InsertEnter", "CursorHold" }
        })

        require("luasnip.loaders.from_lua").lazy_load({ lazy_paths = "./lua/xfaf/snippets" })
        require("luasnip.loaders.from_vscode").lazy_load()
    end,
    dependencies = "rafamadriz/friendly-snippets",
}
