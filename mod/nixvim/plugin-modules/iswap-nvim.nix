{ lib, ... }:
lib.nixvim.plugins.neovim.mkNeovimPlugin {
  name = "iswap";
  package = "duck-nvim";
  maintainers = [ ];
}
