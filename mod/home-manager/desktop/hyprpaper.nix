{
  config,
  lib,
  ...
}:
{
  options.xfaf.desktop.hyprpaper.enable = lib.mkEnableOption "install 0x5a4s hyprpaper config";

  config = lib.mkIf config.xfaf.desktop.hyprpaper.enable {
    stylix.targets.hyprpaper.enable = lib.mkForce false;
    services.hyprpaper =
      let
        monitorsWithWallpaper = config.xfaf.desktop.monitors |> lib.filterAttrs (_: v: v.wallpaper != null);
      in
      {
        enable = true;
        settings = {
          preload =
            monitorsWithWallpaper |> lib.mapAttrsToList (_: v: builtins.toString v.wallpaper) |> lib.unique;
          wallpaper = monitorsWithWallpaper |> lib.mapAttrsToList (name: v: "${name}, ${v.wallpaper}");
        };
      };
  };
}
