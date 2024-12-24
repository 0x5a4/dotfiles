{ lib, ... }:
lib.nixvim.neovim-plugin.mkNeovimPlugin {
  name = "duck";
  package = "duck-nvim";
  maintainers = [ ];
  callSetup = false;
}
