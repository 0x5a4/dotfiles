{ lib, ... }:
lib.nixvim.plugins.neovim.mkNeovimPlugin {
  name = "cellular-automaton";
  package = "cellular-automaton-nvim";
  callSetup = false;
  maintainers = [ ];
}
