{ lib, ... }:
lib.nixvim.neovim-plugin.mkNeovimPlugin {
  name = "visual-whitespace";
  package = "visual-whitespace-nvim";
  maintainers = [ ];
}
