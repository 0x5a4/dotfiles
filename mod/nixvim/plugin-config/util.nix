{
  pkgs,
  lib,
  ...
}:
with lib.xfaf.nixvim;
with lib.nixvim;
{
  extraPlugins = with pkgs.vimPlugins; [
    bufdelete-nvim
    mkdir-nvim
  ];

  # fterm

  keymaps = [
    #bufdelete
    (nnoremap "<leader>c" "<cmd>Bdelete<CR>")
    #vimtex
    (nnoremap "<leader>vt" "<cmd>VimtexCompile<CR>")
  ];

  plugins = {
    better-escape = {
      enable = true;
      settings = {
        default_mappings = false;
        mappings =
          let
            esc-mapping = {
              k.j = "<esc>";
            };
          in
          {
            i = esc-mapping;
            x = esc-mapping;
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
  };

}
