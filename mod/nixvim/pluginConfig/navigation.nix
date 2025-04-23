{
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.xfaf.nixvim)
    nnoremap
    nxonoremap
    onoremap
    noremap'
    keyBindsFromAttrs
    ;

  inherit (lib.nixvim)
    mkRaw
    ;
in
{
  keymaps = lib.flatten [
    (keyBindsFromAttrs nnoremap {
      # oil
      "-" = "<cmd>Oil<CR>";

      # Telescope
      "<leader>ts" = "<cmd>Telescope lsp_document_symbols<CR>";
      "<leader>te" = "<cmd>Telescope diagnostics<CR>";
      "<leader>tq" = "<cmd>Telescope spell_suggest<CR>";
      "<leader>tc" = "<cmd>Telescope git_commits<CR>";
      "<leader>tf" = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
      "<leader>tg" = "<cmd>Telescope live_grep<CR>";
      "<leader>tz" = "<cmd>Telescope symbols<CR>";
      "<leader>tt" = "<cmd>TodoTelescope<CR>";
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
    })

    # flash
    (nxonoremap "s" (mkRaw "require('flash').jump"))
    (nxonoremap "S" (mkRaw "require('flash').treesitter"))
    (onoremap "r" (mkRaw "require('flash').remote"))
    (noremap' [ "o" "x" ] "R" (mkRaw "require('flash').treesitter_search"))
  ];

  highlight.FlashLabel.link = "@string";

  extraPlugins = [ pkgs.vimPlugins.telescope-symbols-nvim ];

  plugins = {
    cheatsheet.cheatsheet = {
      git = {
        "<leader>tc" = "Show git commits";
      };
      navigation = {
        "-" = "Open file explorer";
        "s" = "Flash jump";
        "S" = "Flash treesitter jump";
        "R" = "Flash treesitter search";
        "<leader>tt" = "Show Project Todo Comments";
        "<leader>ts" = "Show Document Symbols";
        "<leader>te" = "Show Document Diagnostics";
        "<leader>tq" = "Show Spell suggestions for the word under the cursor";
        "<leader>tf" = "Fuzzy find in the current buffer";
        "<leader>tg" = "Fuzzy find in the current project";
        "<leader>tz" = "Show List of Symbols (like Emoji)";
        "gi" = "Show incoming calls";
        "gd" = "Goto Definition";
        "<C-p>" = "Goto File";
        "<C-M-p>" = "Goto File, not respecting ignore files";
      };
    };

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

    stay-in-place.enable = true;

    tmux-navigator = {
      enable = true;
      settings = {
        disable_when_zoomed = 1;
        no_mappings = 1;
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
    };

    todo-comments.enable = true;
  };
}
