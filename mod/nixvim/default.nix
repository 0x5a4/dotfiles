{ outputs, ... }:
{
  imports = [
    ./autocmd.nix
    ./binds.nix
    ./ft.nix
    ./plugins
    ./settings.nix
  ];

  nixpkgs.overlays = [ outputs.overlays.vimPlugins ];

  plugins.lz-n.enable = true;

  # TODO: enable me
  # colorscheme = "tokyonight";
  colorschemes.tokyonight = {
    enable = true;
    settings.style = "night";
  };
}
