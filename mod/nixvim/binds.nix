{ lib, ... }:
with lib.xfaf.nixvim;
with lib.nixvim;
{
  globals = {
    mapleader = " ";
    maplocalleader = ",";
  };

  keymaps = lib.flatten [
    (keyBindsFromAttrs nnoremap {
      # Jump to start/end of line
      "H" = "^";
      "L" = "$";
      # LSP Stuff
      "<C-Space>" = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      "<leader>r" = "<cmd>lua vim.lsp.buf.rename()<CR>";
      "<C-q>" = "<cmd>lua vim.lsp.buf.hover()<CR>";
      "<C-f>" = "<cmd>lua vim.lsp.buf.format({ async = true })<CR>";
      # Buffer Navigation
      "<leader>l" = ":bn<CR>";
      "<leader>h" = ":bp<CR>";
      "<leader>C" = ":bd<CR>";
      # Quick save/quit
      "<leader>w" = ":wa<CR>";
      "<leader>q" = mkRaw ''
        function()
          vim.cmd("wa")
          vim.cmd("qa")
        end
      '';
      # Toggle mouse
      "<leader>om" = mkRaw ''
        function()
          if #vim.opt.mouse:get() == 0 then
              vim.opt.mouse = "a"
          else
              vim.opt.mouse = ""
          end
        end
      '';
    })

    # Cut
    (nnoremap "xx" "dd")
    (nnoremap "X" "D")
    (xnoremap "x" "d")

    # Text objects
    (keyBindsFromAttrs onoremap {
      "ar" = "a]";
      "ir" = "i]";
      "ac" = "a}";
      "ic" = "i}";
      "aq" = "a\"";
      "iq" = "i\"";
      "az" = "a'";
      "iz" = "i'";
    })
  ];
}
