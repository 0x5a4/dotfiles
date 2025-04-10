{
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.xfaf.nixvim)
    nnoremap
    xnoremap
    ;
in
{
  extraPlugins = with pkgs.vimPlugins; [
    bufdelete-nvim
    mkdir-nvim
    vim-fireplace
  ];

  extraPackages = [ pkgs.python3 ];

  keymaps = [
    # bufdelete
    (nnoremap "<leader>c" "<cmd>Bdelete<CR>")
    # vimtex
    (nnoremap "<leader>vt" "<cmd>VimtexCompile<CR>")
    # vim-fireplace
    (nnoremap "<localleader>ee" "<cmd>Eval<CR>")
    (nnoremap "<localleader>ef" "<cmd>%Eval<CR>")
    # cheatsheet
    (nnoremap "<leader>?" "<cmd>Cheatsheet<CR>")

    (xnoremap "kj" "<esc>")
    # hex
    (nnoremap "<leader>oh" "<cmd>HexToggle<CR>")
    # cloak
    (nnoremap "<leader>oc" "<cmd>CloakToggle<CR>")
  ];

  plugins = {
    cheatsheet = {
      enable = true;
      settings.bundled_cheatsheets.enabled = [ "default" ];
      cheatsheet = {
        navigation = {
          "<leader>c" = "Close the current buffer";
        };
        util = {
          "<leader>vt" = "Preview .tex files";
          "<leader>?" = "Open the cheatsheet";
        };
      };
    };

    better-escape = {
      enable = true;
      settings = {
        default_mappings = false;
        mappings = {
          c.k.j = "<esc>";
          i.k.j = "<esc>";
          s.k.j = "<esc>";
        };
      };
    };

    vimtex = {
      enable = true;
      texlivePackage = null;
      settings = {
        view_method = "zathura";
        quickfix_mode = 0;
        syntax_conceal = {
          accents = 1;
          cites = 1;
          fancy = 1;
          greek = 1;
          ligatures = 1;
          math_delimiters = 1;
          math_super_sub = 1;
          math_symbols = 1;
          spacing = 1;
          styles = 1;
          math_bounds = 0;
          math_fracs = 0;
          sections = 0;
        };
      };
    };

    floaterm = {
      enable = true;
      settings = {
        height = 0.8;
        keymap_toggle = "<A-t>";
      };
    };

    hex.enable = true;

    cloak = {
      enable = true;
      settings = {
        enabled = true;
        cloak_telescope = true;
        cloak_length = 12;
      };
    };
  };
}
