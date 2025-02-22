{ lib, ... }:
let
  inherit (lib.xfaf.nixvim)
    keyBindsFromAttrs
    nnoremap
    onoremap
    xnoremap
    ;

  inherit (lib.nixvim)
    mkRaw
    ;
in
{
  globals = {
    mapleader = " ";
    maplocalleader = ",";
  };

  plugins.cheatsheet.cheatsheet = {
    editing = {
      "xx" = "Cut the current line";
      "X" = "Cut to end of the current line";
      "x" = "Cut the current selection";
    };
    navigation = {
      "H" = "Jump to end of line";
      "L" = "Jump to begin of line";
      "<leader>l" = "Go to the buffer to the right";
      "<leader>h" = "Go to the buffer to the right";
    };
    util = {
      "<leader>w" = "Write all buffers";
      "<leader>q" = "Write all buffers and quit neovim";
      "<leader>om" = "Toggle mouse";
    };
    lsp = {
      "<C-Space>" = "Show code actions";
      "<leader>r" = "Rename variable";
      "<C-q>" = "Show extended information about the symbol under the cursor";
      "<C-f>" = "Format the current buffer";
    };
    text-objects = {
      "ar" = "Around square brackets";
      "ir" = "Inside square brackets";
      "ac" = "Around curly brackets";
      "ic" = "Inside curly brackets";
      "aq" = "Around quotes";
      "iq" = "Inside quotes";
      "az" = "Around single quotes";
      "iz" = "Inside single quotes";
    };
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
