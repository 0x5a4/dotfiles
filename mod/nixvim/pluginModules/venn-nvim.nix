{ lib, ... }:
lib.nixvim.plugins.neovim.mkNeovimPlugin {
  name = "venn";
  package = "venn-nvim";
  callSetup = false;
  maintainers = [ ];
}
