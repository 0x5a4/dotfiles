{ lib, ... }:
let
  inherit (lib.xfaf.nixvim)
    lazyKeyBindsOf
    keyBindsFromAttrs
    nnoremap
    ;
in
{
  keymaps = keyBindsFromAttrs nnoremap {
    "<leader>og" = "<cmd>Gitsigns toggle_linehl<CR>";
    "<leader>gb" = "<cmd>Gitsigns blame<CR>";
    "<leader>gx" = "<cmd>Gitsigns toggle_deleted<CR>";
    "<leader>gj" = "<cmd>Gitsigns next_hunk<CR>";
    "<leader>gk" = "<cmd>Gitsigns prev_hunk<CR>";
    "<leader>g+" = "<cmd>Gitsigns stage_hunk<CR>";
    "<leader>gs" = "<cmd>Gitsigns stage_buffer<CR>";
    "<leader>g#" = "<cmd>Gitsigns undo_stage_hunk<CR>";
    "<leader>grr" = "<cmd>Gitsigns reset_hunk<CR>";

    "<leader>gck" = "<cmd>GitConflictPrevConflict<CR>";
    "<leader>gcj" = "<cmd>GitConflictNextConflict<CR>";
    "<leader>gco" = "<cmd>GitConflictChooseOurs<CR>";
    "<leader>gct" = "<cmd>GitConflictChooseTheirs<CR>";
  };
  
  plugins = {
    cheatsheet.cheatsheet.git = {
      "<leader>og" = "Toggle line based diff highlighting";
      "<leader>gb" = "Git blame";
      "<leader>gx" = "Show deleted lines";
      "<leader>gj" = "Go to the next hunk";
      "<leader>gk" = "Go to the next hunk";
      "<leader>g+" = "Stage the hunk under the cursor";
      "<leader>gs" = "Stage the entire buffer";
      "<leader>g#" = "Undo hunk staging";
      "<leader>grr" = "Reset hunk under the cursor";
      "<leader>gcj" = "Got to the next git conflict";
      "<leader>gck" = "Got to the previous git conflict";
      "<leader>gco" = "Choose our modifications of the conflict under the cursor";
      "<leader>gct" = "Choose their modifications of the conflict under the cursor";
    };

    gitsigns = {
      enable = true;
      settings = {
        signcolumn = false;
        numhl = true;
        linehl = false;
      };
    };

    git-conflict = {
      enable = true;
      settings.default_mappings = false;
    };
  };
}
