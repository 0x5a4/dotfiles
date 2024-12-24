{ lib, ... }:
lib.nixvim.neovim-plugin.mkNeovimPlugin {
  name = "cellular-automaton";
  package = "cellular-automaton-nvim";
  callSetup = false;
  maintainers = [ ];
}
