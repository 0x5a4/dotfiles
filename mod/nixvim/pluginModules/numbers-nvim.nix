{ lib, ... }:
lib.nixvim.plugins.neovim.mkNeovimPlugin {
  name = "numbers-nvim";
  package = "numbers-nvim";
  moduleName = "numbers";
  maintainers = [ ];
}
