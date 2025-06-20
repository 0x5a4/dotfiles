{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.xfaf.desktop.swayidle.enable = lib.mkEnableOption "install 0x5a4s swayidle config";

  config = lib.mkIf config.xfaf.desktop.swayidle.enable {
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        effect-blur = "20x3";
        clock = true;
        ignore-empty-password = true;
        daemonize = true;
        show-failed-attempts = true;
        screenshots = true;
      };
    };

    services.swayidle = {
      enable = true;
      timeouts = lib.singleton {
        timeout = 600;
        command = lib.getExe config.programs.swaylock.package;
      };
      events = [
        {
          event = "lock";
          command = lib.getExe config.programs.swaylock.package;
        }
        {
          event = "before-sleep";
          command = "${lib.getExe config.programs.swaylock.package}; ${lib.getExe pkgs.playerctl} pause";
        }
      ];
    };
  };
}
