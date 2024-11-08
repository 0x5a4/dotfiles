{
  config,
  lib,
  ...
}:
{
  options.xfaf.desktop.wob.enable = lib.mkEnableOption "install 0x5a4s wob config";

  config = lib.mkIf config.xfaf.desktop.wob.enable {
    services.wob = {
      enable = true;
      systemd = true;
    };

    services.wob.settings = {
      "" = {
        orientation = "vertical";
        anchor = "left";
        width = 50;
        height = 300;
        margin = 20;
      };
      "style.muted" = {
        bar_color = "44475a";
      };
      "style.brightness" = {
        bar_color = "f1fa8c";
      };
    };
  };
}
