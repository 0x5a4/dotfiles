{ lib, outputs, ... }:
{
  imports = lib.xfaf.importAllChildren ./.;

  nixpkgs.overlays = [ outputs.overlays.vimPlugins ];

  plugins.lz-n.enable = true;

  viAlias = true;
  vimAlias = true;

  performance.byteCompileLua = {
    enable = true;
    nvimRuntime = true;
    plugins = true;
  };

  colorschemes.tokyonight = {
    enable = true;
    settings.style = "night";
  };
}
