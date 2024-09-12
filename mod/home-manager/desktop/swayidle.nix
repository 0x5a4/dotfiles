{
  config,
  lib,
  pkgs,
  ...
}: {
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
      events = [
        {
          event = "lock";
          command = "${config.programs.swaylock.package}/bin/swaylock";
        }
        {
          event = "before-sleep";
          command = "${config.programs.swaylock.package}/bin/swaylock; ${pkgs.playerctl}/bin/playerctl pause";
        }
      ];

      # timeouts =
      #   [
      #     {
      #       timeout = 300;
      #       command = "${config.programs.swaylock.package}/bin/swaylock";
      #     }
      #   ]
      #   ++ (lib.lists.optionals config.xfaf.desktop.hyprland.enable [
      #     {
      #       timeout = 420;
      #       command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
      #       resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      #     }
      #   ]);
    };
  };
}
