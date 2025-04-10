{ lib, ... }:
lib.nixvim.plugins.neovim.mkNeovimPlugin {
  name = "iswap";
  package = "iswap-nvim";
  maintainers = [ ];
}
