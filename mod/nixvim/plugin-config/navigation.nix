{
  pkgs,
  lib,
  ...
}:
with lib.xfaf.nixvim;
with lib.nixvim;
{
  keymaps = [
    # oil
    (nnoremap "-" "<cmd>Oil<CR>")

    # flash
    (nxonoremap "s" (mkRaw "require('flash').jump"))
    (nxonoremap "S" (mkRaw "require('flash').treesitter"))
    (onoremap "r" (mkRaw "require('flash').remote"))
    (noremap' [ "o" "x" ] "R" (mkRaw "require('flash').treesitter_search"))

    # todo comments
    (nnoremap "<leader>tt" "<cmd>TodoTelescope<CR>")
  ];

  highlight.FlashLabel.link = "@string";

  extraPlugins = [ pkgs.vimPlugins.telescope-symbols-nvim ];

  plugins = {
    oil = {
      enable = true;
      settings.columns = [
        "icon"
        "size"
      ];
    };

    spider = {
      enable = true;
      keymaps.silent = true;
      keymaps.motions = lib.genAttrs [
        "w"
        "e"
        "b"
        "ge"
      ] lib.id;
    };

    flash = {
      enable = true;
      settings = {
        labels = "abdefgiklnopqrswxyz234579+#";
        jump.autojump = true;
        modes.search.enabled = true;
      };
    };

    lastplace.enable = true;

    tmux-navigator = {
      enable = true;
      settings = {
        disable_when_zoomed = 1;
        no_mappings = 0;
        save_on_switch = 2; # write all buffers
      };
      keymaps = keyBindsFromAttrs nnoremap {
        "<A-l>" = "right";
        "<A-h>" = "left";
        "<A-j>" = "down";
        "<A-k>" = "up";
      };
    };

    hardtime = {
      enable = true;
      settings.disable_mouse = false;
    };

    telescope = {
      enable = true;
      extensions.fzy-native.enable = true;
      settings = {
        pickers.spell_suggest.theme = "cursor";
        defaults = {
          sorting_strategy = "ascending";
          layout_config.horizontal.prompt_position = "top";
          mappings = {
            i = {
              "<C-j>" = "move_selection_next";
              "<C-k>" = "move_selection_previous";
              "<esc>" = "close";
              "<C-q>" = "close";
            };
            n = {
              "q" = "close";
            };
          };
        };
      };
      lazyLoad = {
        enable = true;
        settings = {
          cmd = "Telescope";
          keys =
            lazyKeyBindsOf
            <| keyBindsFromAttrs nnoremap {
              "<leader>ts" = "<cmd>Telescope lsp_document_symbols<CR>";
              "<leader>te" = "<cmd>Telescope diagnostics<CR>";
              "<leader>tq" = "<cmd>Telescope spell_suggest<CR>";
              "<leader>tc" = "<cmd>Telescope git_commits<CR>";
              "<leader>tf" = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
              "<leader>tg" = "<cmd>Telescope live_grep<CR>";
              "<leader>tz" = "<cmd>Telescope symbols<CR>";
              "gi" = "<cmd>Telescope lsp_incoming_calls<CR>";
              "gd" = "<cmd>Telescope lsp_definitions<CR>";
              "<C-p>" = mkRaw ''
                function()
                    require("telescope.builtin").find_files({
                        cwd = vim.fs.root(0, ".git"),
                    })
                end
              '';
              "<C-M-p>" = mkRaw ''
                function()
                    require("telescope.builtin").find_files({
                        cwd = vim.fs.root(0, ".git"),
                        hidden = true,
                        no_ignore = true,
                        no_ignore_parent = true,
                    })
                end
              '';
            };
        };
      };
    };

    todo-comments = {
      enable = true;
      lazyLoad.enable = true;
      lazyLoad.settings.event = "User File";
    };
  };
}
