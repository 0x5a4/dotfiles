{ lib, ... }:
lib.nixvim.plugins.neovim.mkNeovimPlugin {
  name = "duck";
  package = "duck-nvim";
  maintainers = [ ];
  callSetup = false;
}
