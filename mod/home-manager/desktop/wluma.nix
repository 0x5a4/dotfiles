{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.xfaf.desktop.wluma.enable = lib.mkEnableOption "enable wluma";

  config = lib.mkIf config.xfaf.desktop.wluma.enable {
    systemd.user.services.wluma = {
      Unit = {
        PartOf = [ config.wayland.systemd.target ];
        After = [ config.wayland.systemd.target ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };

      Service = {
        ExecStart = "${lib.getExe pkgs.wluma}";
        Restart = "on-failure";
        KillMode = "mixed";
      };

      Install.WantedBy = [ config.wayland.systemd.target ];
    };
  };
}
