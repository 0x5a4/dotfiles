{
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.xfaf.nixvim)
    veryLazyEvent
    lazyKeyBindsOf
    noremap'
    nnoremap
    keyBindsFromAttrs
    ;

  inherit (lib.nixvim)
    mkRaw
    ;

  siremap = noremap' [
    "s"
    "i"
  ];
in
{
  extraPlugins = with pkgs.vimPlugins; [
    antonys-macro-repeater
    vim-cutlass
    vim-indent-object
    vim-repeat
    vim-sort-motion
    vim-targets
  ];

  keymaps = lib.flatten [
    (keyBindsFromAttrs nnoremap {
      "<leader>+" = "<cmd>ToggleAlternate<CR>";

      "<leader>a" = "<cmd>ISwapWith<CR>";
      "<leader>A" = "<cmd>ISwap<CR>";

      "<leader>ov" = mkRaw ''
        function()
            local venn_enabled = vim.inspect(vim.b.venn_enabled)
            if venn_enabled == "nil" then
                vim.b.venn_enabled = true
                vim.cmd [[setlocal ve=all]]
                -- draw a line on HJKL keystokes
                vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
                vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
                vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
                vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
                -- draw a box by pressing "f" with visual selection
                vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
            else
                vim.cmd [[setlocal ve=]]
                vim.cmd [[mapclear <buffer>]]
                vim.b.venn_enabled = nil
            end
        end
      '';
    })

    (keyBindsFromAttrs siremap {
      "<C-E>" = mkRaw ''
        function()
            local luasnip = require("luasnip")
            if luasnip.choice_active() then
                luasnip.change_choice(1)
            end
        end
      '';
      "<C-M-p>" = mkRaw ''
        function()
            local luasnip = require("luasnip")
            if luasnip.choice_active() then
                luasnip.change_choice(-1)
            end
        end
      '';
    })
  ];

  plugins = {
    cheatsheet.cheatsheet = {
      editing = {
        "ys" = "Surround text object";
        "cs" = "Change surrounding character";
        "ds" = "Delete surrounding character";
        "<leader>+" = "Toggle Alternate of word under cursor (e.g. true <=> false)";
        "<leader>a" = "Swap Treesitter Node under cursor with another one";
        "<leader>A" = "Swap Two Treesitter Nodes";
        "<leader>ov" = "Toggle venn mode";

      };
      paredit = {
        ">)" = "Slurp forwards";
        ">(" = "Barf backwards";
        "<)" = "Barf forwards";
        "<(" = "Slurp backwards";

        ">p" = "Drag element pairs right";
        "<p" = "Drag element pairs left";

        ">f" = "Drag form right";
        "<f" = "Drag form left";

        "E" = "Jump to next element tail";
        "W" = "Jump to next element head";
        "B" = "Jump to previous element head";
        "gE" = "Jump to previous element tail";

        "af" = "Around form";
        "if" = "In form";
        "aF" = "Around top level form";
        "iF" = "In top level form";
        "ae" = "Around element";
        "ie" = "Element";
      };
    };

    nvim-surround.enable = true;

    alternate-toggler.enable = true;

    commentary.enable = true;

    nvim-autopairs = {
      enable = true;

      settings.enable_check_bracket_line = true;

      luaConfig.post = # lua
        ''
          local autopairs = require("nvim-autopairs")
          local rule = require("nvim-autopairs.rule")

          -- dont double quote lisps
          autopairs.get_rules("'")[1].not_filetypes = { "scheme", "lisp", "clojure" }
          autopairs.get_rules("`")[1].not_filetypes = { "scheme", "lisp", "clojure" }

          autopairs.add_rules({
              rule("$", "$", { "tex", "latex" }),
          })
        '';
    };

    smartcolumn = {
      enable = true;
      settings = {
        colorcolumn = "100";
        scope = "window";
        disabled_filetypes = [
          "help"
          "checkhealth"
          "TelescopePrompt"
          "lspinfo"
        ];
      };
    };

    nvim-paredit.enable = true;

    vim-move = {
      enable = true;
      settings = {
        key_modifier = "C";
        key_modifier_visualmode = "C";
      };
    };

    iswap.enable = true;

    venn.enable = true;

    friendly-snippets.enable = true;

    luasnip.enable = true;
  };
}
