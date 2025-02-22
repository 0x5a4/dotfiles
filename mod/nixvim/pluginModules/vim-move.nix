{ lib, ... }:
lib.nixvim.plugins.vim.mkVimPlugin {
  name = "vim-move";
  maintainers = [ ];
  globalPrefix = "move_";
}
