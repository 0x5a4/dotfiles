{ lib, ... }:
let
  inherit (lib.xfaf.nixvim)
    lazyKeyBindsOf
    keyBindsFromAttrs
    nnoremap
    ;
in
{
  plugins = {
    gitsigns = {
      enable = true;
      settings = {
        signcolumn = false;
        numhl = true;
        linehl = false;
      };
      lazyLoad = {
        enable = true;
        settings = {
          event = "User GitFile";
          keys =
            lazyKeyBindsOf
            <| keyBindsFromAttrs nnoremap {
              "<leader>og" = "<cmd>Gitsigns toggle_linehl<CR>";
              "<leader>gb" = "<cmd>Gitsigns blame<CR>";
              "<leader>gx" = "<cmd>Gitsigns toggle_deleted<CR>";
              "<leader>gj" = "<cmd>Gitsigns next_hunk<CR>";
              "<leader>gk" = "<cmd>Gitsigns prev_hunk<CR>";
              "<leader>g+" = "<cmd>Gitsigns stage_hunk<CR>";
              "<leader>gs" = "<cmd>Gitsigns stage_buffer<CR>";
              "<leader>g#" = "<cmd>Gitsigns undo_stage_hunk<CR>";
              "<leader>grr" = "<cmd>Gitsigns reset_hunk<CR>";
            };
        };
      };
    };

    git-conflict = {
      enable = true;
      settings.default_mappings = false;
      lazyLoad = {
        enable = true;
        settings = {
          event = "User GitFile";
          keys =
            lazyKeyBindsOf
            <| keyBindsFromAttrs nnoremap {
              "<leader>gck" = "<cmd>GitConflictPrevConflict<CR>";
              "<leader>gcj" = "<cmd>GitConflictNextConflict<CR>";
              "<leader>gco" = "<cmd>GitConflictChooseOurs<CR>";
              "<leader>gct" = "<cmd>GitConflictChooseTheirs<CR>";
            };
        };
      };
    };
  };
}
