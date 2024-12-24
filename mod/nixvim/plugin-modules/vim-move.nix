{ lib, ... }:
lib.nixvim.vim-plugin.mkVimPlugin {
  name = "vim-move";
  maintainers = [ ];
  globalPrefix = "move_";
}
