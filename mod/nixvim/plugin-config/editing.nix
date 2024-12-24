{
  pkgs,
  xfaf-lib,
  lib,
  ...
}:
with xfaf-lib.nixvim;
with lib.nixvim;
{
  extraPlugins = with pkgs.vimPlugins; [
    antonys-macro-repeater
    vim-cutlass
    vim-indent-object
    vim-repeat
    vim-sort-motion
    vim-targets
  ];

  plugins = {
    nvim-surround = {
      enable = true;
      lazyLoad.enable = true;
      lazyLoad.settings.event = veryLazyEvent;
    };

    alternate-toggler = {
      enable = true;
      lazyLoad.enable = true;
      lazyLoad.settings = {
        cmd = "ToggleAlternate";
        keys = lazyKeyBindsOf [
          (nnoremap "<leader>+" "<cmd>ToggleAlternate<CR>")
        ];
      };
    };

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

      lazyLoad.enable = true;
      lazyLoad.settings.event = "InsertEnter";
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

    nvim-paredit = {
      enable = true;
      lazyLoad.enable = true;
      lazyLoad.settings.ft = "clojure";
    };

    vim-move = {
      enable = true;
      settings = {
        key_modifier = "C";
        key_modifier_visualmode = "C";
      };
    };

    iswap = {
      enable = true;
      lazyLoad.enable = true;
      lazyLoad.settings = {
        cmd = [
          "ISwap"
          "ISwapWith"
          "ISwapWithLeft"
          "ISwapWithRight"
          "ISwapNode"
          "ISwapNodeWith"
          "ISwapNodeWithLeft"
          "ISwapNodeWithRight"
          "IMove"
          "IMoveWith"
          "IMoveWithLeft"
          "IMoveWithRight"
          "IMoveNode"
          "IMoveNodeWith"
          "IMoveNodeWithLeft"
          "IMoveNodeWithRight"
        ];
        keys =
          lazyKeyBindsOf
          <| keyBindsFromAttrs nnoremap {
            "<leader>a" = "<cmd>ISwapWith<CR>";
            "<leader>A" = "<cmd>ISwap<CR>";
          };
      };
    };

    venn = {
      enable = true;
      lazyLoad.enable = true;
      lazyLoad.settings = {
        cmd = [
          "VBox"
          "VBoxO"
          "VBoxD"
          "VBoxDO"
          "VBoxH"
          "VBoxHO"
        ];
        keys = lazyKeyBindsOf [
          (nnoremap "<leader>ov" (mkRaw
          ''
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
          ''))
        ];
      };
    };
  };
}
