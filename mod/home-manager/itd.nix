{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.xfaf.services.itd;
  format = pkgs.formats.toml { };
  configFile = format.generate "itd.toml" cfg.settings;
in
{
  options.xfaf.services.itd = {
    enable = lib.mkEnableOption "itd, a daemon to interact with the PineTime running InfiniTime";

    package = lib.mkPackageOption pkgs "itd" { };

    settings = lib.mkOption {
      type = format.type;
      default = { };
      description = ''
        Configuration to use for itd. See
        <https://gitea.elara.ws/Elara6331/itd/src/branch/master/itd.toml>
        for available options.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile = lib.mkIf (cfg.settings != { }) {
      "itd.toml" = configFile;
    };

    systemd.user.services.itd = {
      Unit = {
        Description = "InfiniTime Daemon (itd)";
        After = [ "bluetooth.target" ];
      };

      Install.WantedBy = [ "default.target" ];

      Service = {
        ExecStart = lib.getExe' cfg.package "itd";
        Restart = "always";
        StandardOutput = "journal";
      };
    };
  };
}
