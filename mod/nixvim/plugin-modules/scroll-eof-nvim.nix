{ lib, ... }:
lib.nixvim.neovim-plugin.mkNeovimPlugin {
  name = "scroll-eof";
  package = "scroll-eof-nvim";
  moduleName = "scrollEOF";
  maintainers = [ ];
}
