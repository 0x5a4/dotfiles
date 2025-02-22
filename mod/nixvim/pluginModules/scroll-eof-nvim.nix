{ lib, ... }:
lib.nixvim.plugins.neovim.mkNeovimPlugin {
  name = "scroll-eof";
  package = "scroll-eof-nvim";
  moduleName = "scrollEOF";
  maintainers = [ ];
}
