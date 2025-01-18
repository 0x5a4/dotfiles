{ lib, outputs, ... }:
{
  imports = lib.xfaf.importAllChildren ./.;

  nixpkgs.overlays = [ outputs.overlays.vimPlugins ];

  plugins.lz-n.enable = true;

  colorschemes.tokyonight = {
    enable = true;
    settings.style = "night";
  };
}
