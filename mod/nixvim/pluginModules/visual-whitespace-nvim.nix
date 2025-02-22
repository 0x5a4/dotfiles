{ lib, ... }:
lib.nixvim.plugins.neovim.mkNeovimPlugin {
  name = "visual-whitespace";
  package = "visual-whitespace-nvim";
  maintainers = [ ];
}
