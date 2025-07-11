{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.xfaf.desktop.mako = {
    enable = lib.mkEnableOption "install 0x5a4s hyprland config";
    output = lib.mkOption {
      description = "which output to show the notification on";
      type = lib.types.nullOr lib.types.str;
      default = null;
    };
  };

  config = lib.mkIf config.xfaf.desktop.mako.enable {
    home.packages = with pkgs; [
      libnotify
    ];

    services.mako = {
      enable = true;

      settings = {
        default-timeout = 5000;
        output = config.xfaf.desktop.mako.output;
        width = 400;

        "urgency=high" = {
          layer = "overlay";
          default-timeout = 0;
          ignore-timeout = true;
        };
      };
    };
  };
}
